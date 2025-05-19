part of 'clearing_grading_bloc.dart';

abstract class ClearingGradingState extends Equatable {
  const ClearingGradingState();
}

final class ClearingGradingInitial extends ClearingGradingState {
  @override
  List<Object> get props => [];
}

class ClearingGradingPageLoadState extends ClearingGradingState {
  @override
  List<Object> get props => [];
}

class ClearingGradingLoadedDataState extends ClearingGradingState {
  final bool isLoader;
  final bool isBtnLoader;
  final int pageNo;
  final TextEditingController reportNumberController;
  final ScrollController scrollController;
  final ReportActivityModel reportActivityModel;
  final List<ReportActivityData>  listOfFilterReportActivity;
  final Set<String> selectedRowIds;
  final bool isAllSelected;

  ClearingGradingLoadedDataState({
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