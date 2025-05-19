part of 'ofc_splicing_jointing_bloc.dart';

abstract class OfcSplicingJointingState extends Equatable {
  const OfcSplicingJointingState();
}

final class OfcSplicingJointingInitial extends OfcSplicingJointingState {
  @override
  List<Object> get props => [];
}

class OfcSplicingJointingPageLoadState extends OfcSplicingJointingState {
  @override
  List<Object> get props => [];
}

class OfcSplicingJointingLoadedDataState extends OfcSplicingJointingState {
  final bool isLoader;
  final bool isBtnLoader;
  final int pageNo;
  final TextEditingController reportNumberController;
  final ScrollController scrollController;
  final ReportActivityModel reportActivityModel;
  final List<ReportActivityData>  listOfFilterReportActivity;
  final Set<String> selectedRowIds;
  final bool isAllSelected;

  OfcSplicingJointingLoadedDataState({
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