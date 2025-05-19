part of 'rou_handover_bloc.dart';

abstract class RouHandoverState extends Equatable {
  const RouHandoverState();
}

final class RouHandoverInitial extends RouHandoverState {
  @override
  List<Object> get props => [];
}

class RouHandoverPageLoadState extends RouHandoverState {
  @override
  List<Object> get props => [];
}

class RouHandoverLoadedDataState extends RouHandoverState {
  final bool isLoader;
  final bool isBtnLoader;
  final int pageNo;
  final TextEditingController reportNumberController;
  final ScrollController scrollController;
  final ReportActivityModel reportActivityModel;
  final List<ReportActivityData>  listOfFilterReportActivity;
  final Set<String> selectedRowIds;
  final bool isAllSelected;

  RouHandoverLoadedDataState({
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
    pageNo,
    isBtnLoader,
    reportNumberController,
    scrollController,
    reportActivityModel,
    listOfFilterReportActivity,
    selectedRowIds,
    isAllSelected,
  ];
}