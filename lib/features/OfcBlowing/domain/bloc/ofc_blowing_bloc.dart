import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/ClearingGrading/helper/clearing_grading_helper.dart';
import 'package:steel_contractor/features/OfcBlowing/helper/ofc_blowing_helper.dart';
import 'package:url_launcher/url_launcher.dart';

part 'ofc_blowing_event.dart';

part 'ofc_blowing_state.dart';

class OfcBlowingBloc extends Bloc<OfcBlowingEvent, OfcBlowingState> {
  OfcBlowingBloc() : super(OfcBlowingInitial()) {
    on<OfcBlowingPageLoadEvent>(_pageLoad);
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

  _pageLoad(OfcBlowingPageLoadEvent event, emit) async {
    emit(OfcBlowingPageLoadState());
    isLoader = false;
    isBtnLoader = false;
    pageNo = 1;
    reportNumberController.text = "";
    remarksController.text = "";
    scrollController = ScrollController();
     selectedRowIds = {};
     isAllSelected = false;
    await fetchReportActivity(context: event.context);
    _eventCompleted(emit);
  }

  fetchReportActivity({required BuildContext context}) async {
    var res = await ClearingGradingHelper.reportByActivityIdAPI(
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
    emit(OfcBlowingPageLoadState());
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

  loadDataTable({required BuildContext context, emit}) {
    emit(OfcBlowingInitial());
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageNo++;
        _eventCompleted(emit);
      }
    });
  }

  _submit({
    required BuildContext context,
    required String status,
    required String remark,
  }) async {
    try {
      var res = await ClearingGradingHelper.saveActivityApproveReject(
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
    return OfcBlowingHelper.showConfirmationDialog(
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
    return OfcBlowingHelper.showConfirmationDialog(
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
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch ${event.url}';
        }
      }
    }
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<OfcBlowingState> emit) {
    emit(
      OfcBlowingLoadedDataState(
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
