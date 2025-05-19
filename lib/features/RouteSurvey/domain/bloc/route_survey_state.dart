part of 'route_survey_bloc.dart';

abstract class RouteSurveyState extends Equatable {
  const RouteSurveyState();
}

final class RouteSurveyInitial extends RouteSurveyState {
  @override
  List<Object> get props => [];
}

class RouteSurveyPageLoadState extends RouteSurveyState {
  @override
  List<Object> get props => [];
}

class RouteSurveyLoadedDataState extends RouteSurveyState {
  final bool isLoader;
  final bool isBtnLoader;
  final int pageNo;
  final TextEditingController reportNumberController;
  final TextEditingController remarksController;
  final ScrollController scrollController;
  final ReportActivityModel reportActivityModel;
  final List<ReportActivityData>  listOfFilterReportActivity;
  final Set<String> selectedRowIds;
  final bool isAllSelected;

  RouteSurveyLoadedDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.pageNo,
    required this.reportNumberController,
    required this.remarksController,
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
    remarksController,
    scrollController,
    reportActivityModel,
    listOfFilterReportActivity,
    selectedRowIds,
    isAllSelected,
  ];
}