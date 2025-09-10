import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';
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
    await fetchReportActivity(context: event.context);
    _eventCompleted(emit);
  }

  fetchReportActivity({required BuildContext context}) async {
    var res = await NDTRTHelper.reportByActivityIdAPI(
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
    reportNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 9) {
    } else {}
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
      var res = await NDTRTHelper.saveActivityApproveReject(
        context: context,
        status: status,
        remark: remark,
      );
      if (res != null) {}
    } catch (e) {
      log("updateFeasibility-->${e.toString()}");
    }
  }

  _activityApproved(ActivityApprovedEvent event, emit) async {
    return NDTRTHelper.showConfirmationDialog(
      context: event.context,
      emit: emit,
      isApproval: true,
      remarksController:TextEditingController(text: ""),
      onConfirm: () async {
        isBtnLoader = true;
        _eventCompleted(emit);
        await _submit(
          status: "1",
          remark: "",
          context: event.context,
        );
        isBtnLoader = false;
        _eventCompleted(emit);
      },
    );
  }

   _activityReject(ActivityRejectEvent event, emit) async {
    remarksController.text = "";
    return NDTRTHelper.showConfirmationDialog(
      context: event.context,
      emit: emit,
      isApproval: false,
      remarksController: remarksController,
      onConfirm: () async {
        isBtnLoader = true;
        _eventCompleted(emit);
        await _submit(
          status: "2",
          remark: remarksController.text.trim(),
          context: event.context,
        );
        isBtnLoader = false;
        _eventCompleted(emit);
      },
    );
  }

  _downloadPdf(DownloadPdfEvent event, emit) async {
    for (var data in listOfFilterReportActivity) {
      if (data.attachFile != null && data.attachFile!.isNotEmpty) {
        final Uri uri = Uri.parse(event.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
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
