

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';

abstract class BackfillingState extends Equatable {
  const BackfillingState();
}

final class BackfillingInitial extends BackfillingState {
  @override
  List<Object> get props => [];
}

class BackfillingPageLoadState extends BackfillingState {
  @override
  List<Object> get props => [];
}

class BackfillingLoadedDataState extends BackfillingState {
  final bool isLoader;
  final bool isBtnLoader;
  final int pageNo;
  final TextEditingController reportNumberController;
  final ScrollController scrollController;
  final ReportActivityModel reportActivityModel;
  final List<ReportActivityData>  listOfFilterReportActivity;
  final Set<String> selectedRowIds;
  final bool isAllSelected;

  BackfillingLoadedDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.pageNo,
    required this.reportNumberController,
    required this.scrollController,
    required this.reportActivityModel,
    required this.listOfFilterReportActivity,
    required this.selectedRowIds,
    required this.isAllSelected,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    isLoader,
    isBtnLoader,
    pageNo,
    reportNumberController,
    scrollController,
    reportActivityModel,
    listOfFilterReportActivity,
   selectedRowIds,
   isAllSelected,
  ];
}