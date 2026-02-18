import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Backfilling/presentation/widgets/confirmation_widget.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';
import 'package:steel_contractor/features/Home/helper/home_helper.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/NDTRT/domain/bloc/ndt_rt_event.dart';
import 'package:steel_contractor/features/NDTRT/domain/bloc/ndt_rt_state.dart';
import 'package:steel_contractor/features/NDTRT/helper/ndt_rt_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class NDTRTBloc
    extends Bloc<NDTRTEvent, NDTRTState> {
  NDTRTBloc() : super(NDTRTInitial()) {
    on<NDTRTPageLoadEvent>(_pageLoad);
    on<SearchBpNumberEvent>(_searchBpNumber);
    on<SelectAllCheckBoxEvent>(_selectAllCheckBox);
    on<SelectRowIdCheckBoxEvent>(_selectRowIdCheckBox);
    on<ActivityApprovedEvent>(_activityApproved);
    on<ActivityRejectEvent>(_activityReject);
    on<DownloadPdfEvent>(_downloadPdf);
    on<ImageViewEvent>(_imageView);
    on<SelectTpiEvent>(_tpiChanged);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  int pageNo = 1;
  ScrollController scrollController = ScrollController();
  TextEditingController reportNumberController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  ReportActivityModel reportActivityModel = ReportActivityModel();
  List<ReportActivityData> listOfReportActivity = [];
  List<ReportActivityData> listOfFilterReportActivity = [];

  Set<String> selectedRowIds = {};
  bool isAllSelected = false;

  TpiModel tpiValue = TpiModel();
  List<TpiModel> listOfTpi = [];

  _pageLoad(NDTRTPageLoadEvent event, emit) async {
    emit(NDTRTPageLoadState());
    isLoader = false;
    isBtnLoader = false;
    pageNo = 1;
    reportNumberController.text = "";
    remarksController.text = "";
    scrollController = ScrollController();
    reportActivityModel = ReportActivityModel();
    listOfReportActivity = [];
    listOfFilterReportActivity = [];
    selectedRowIds = {};
    isAllSelected = false;
    tpiValue = TpiModel();
    listOfTpi = [];
    await fetchReportActivity(context: event.context);
    listOfTpi =  (await HomeHelper.tpiApi(context: event.context))??[];
    _eventCompleted(emit);
  }

  fetchReportActivity({required BuildContext context}) async {
    var res = await HomeHelper.reportByActivityIdAPI(
      context: context,
    );
    if (res != null) {
      reportActivityModel = res;
      if (reportActivityModel.success != 400) {
        listOfReportActivity = reportActivityModel.data!;
        listOfFilterReportActivity = listOfReportActivity;
      }
    }
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    String query = reportNumberController.text;
    query = event.searchBpNumber;
    if (event.searchBpNumber.length > 2) {
      listOfFilterReportActivity =
          listOfReportActivity.where((e)=> e.reportNo.toString().contains(query)).toList();
    } else {
      listOfFilterReportActivity = listOfReportActivity;
    }
    _eventCompleted(emit);
  }

  loadDataTable({required BuildContext context, emit}) {
    emit(NDTRTInitial());
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageNo++;
        _eventCompleted(emit);
      }
    });
  }

  _selectAllCheckBox(SelectAllCheckBoxEvent event, emit) {
    if (event.isSelected) {
      selectedRowIds = event.list.map((e) => e.id.toString()).toSet();
      String cleaned = selectedRowIds.toString().replaceAll(RegExp(r'[{}]'), '');
      AppConfig.instanceInit()?.setReportActivityId(newReportActivityId: cleaned.toString());
      print("selectedRowIds--->${selectedRowIds}");
    } else {
      selectedRowIds.clear();
    }
    isAllSelected = selectedRowIds.length == event.list.length;
    _eventCompleted(emit);
  }

  _selectRowIdCheckBox(SelectRowIdCheckBoxEvent event, emit) {
    emit(NDTRTPageLoadState());
    if (event.isSelected) {
      selectedRowIds.add(event.itemId);
      String cleaned = selectedRowIds.toString().replaceAll(RegExp(r'[{}]'), '');
      AppConfig.instanceInit()?.setReportActivityId(newReportActivityId: cleaned.toString());
      print("selectedRowIds--->${selectedRowIds}");
    } else {
      selectedRowIds.remove(event.itemId);
    }
    isAllSelected = selectedRowIds.length == listOfFilterReportActivity.length;
    _eventCompleted(emit);
  }

  _submit({
    required BuildContext context,
    required String status,
    required String remark,
  }) async {
    try {
      var res = await HomeHelper.saveActivityApproveReject(
        context: context,
        status: status,
        remark: remark,
          tpiValue: tpiValue
      );
      if (res != null) {
        return  Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } catch (e) {
      log("updateFeasibility-->${e.toString()}");
    }
  }

  void _openConfirmationDialog({
    required BuildContext context,
    required String status,
    required bool showDropdown,
  }) {
    remarksController.clear();
    tpiValue = TpiModel();
    isBtnLoader = false;
    final roleType = AppConfig.instanceInit()?.loginData.user!.role.toString().toLowerCase();
    final bool shouldShowDropdown = roleType == "client" ? false : showDropdown;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConfirmationDialog(
              title: "Confirm?",
              message: "Are you sure you want to ${status == "1" ? "approve" : "reject"}?",
              showDropdown: shouldShowDropdown,
              remarksController: remarksController,
              isBtnLoading: isBtnLoader,
              dropdownValue: tpiValue,
              items: listOfTpi,
              onChanged: showDropdown
                  ? (val) {
                setState(() {
                  tpiValue = val!;
                });
              }
                  : null,
              onCancel: () {
                Navigator.pop(dialogContext);
              },
              onConfirm: () async {
                if (shouldShowDropdown  && tpiValue.iD == null) {
                  String msg = roleType == "tpi"
                      ? "PMC is required"
                      : roleType == "pmc"
                      ? "Client is required"
                      : "TPI is required";
                  Utils.errorSnackBar(msg: msg, context: context,);
                  return;
                }
                if (remarksController.text.isEmpty) {
                  Utils.errorSnackBar(
                    msg: "Remarks required",
                    context: context,
                  );
                  return;
                }
                setState(() => isBtnLoader = true);
                try {
                  await _submit(
                    status: status,
                    remark: remarksController.text.trim(),
                    context: context,
                  );
                  Navigator.pop(dialogContext);
                } finally {
                  if (context.mounted) {
                    setState(() => isBtnLoader = false);
                  }
                }
              },
            );
          },
        );
      },
    );
  }

  _activityApproved(ActivityApprovedEvent event, emit) {
    _openConfirmationDialog(
      context: event.context,
      status: "1",
      showDropdown: true,
    );
  }

  _activityReject(ActivityRejectEvent event, emit) {
    _openConfirmationDialog(
      context: event.context,
      status: "2",
      showDropdown: false,
    );
  }

  _downloadPdf(DownloadPdfEvent event, emit) async {
    if (event.url.isEmpty|| event.url.isEmpty) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(content: Text("Invalid file URL")),
      );
      return;
    }
    final Uri uri = Uri.parse(event.url);
    try {
      print("Launching URL: $uri");

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not launch");
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(content: Text("Error opening file: $e")),
      );
    }
    _eventCompleted(emit);
  }

  _imageView(ImageViewEvent event, emit) async {
    for (var data in listOfFilterReportActivity) {
      if (data.attachFile != null && data.attachFile!.isNotEmpty) {
        final Uri uri = Uri.parse(event.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(content: Text("File not found on server (404)")),
          );
          throw 'Could not launch ${event.url}';
        }
      }
    }
    _eventCompleted(emit);
  }

  _tpiChanged(SelectTpiEvent event, emit) {
    tpiValue = event.tpiValue;
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<NDTRTState> emit) {
    emit(
      NDTRTLoadedDataState(
        isLoader: isLoader,
        isBtnLoader: isBtnLoader,
        pageNo: pageNo,
        reportNumberController: reportNumberController,
        scrollController: scrollController,
        reportActivityModel: reportActivityModel,
        listOfFilterReportActivity: listOfFilterReportActivity,
        isAllSelected: isAllSelected,
        selectedRowIds: selectedRowIds,
      ),
    );
  }
}
