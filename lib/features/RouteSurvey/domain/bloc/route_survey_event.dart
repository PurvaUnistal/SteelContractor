part of 'route_survey_bloc.dart';

abstract class RouteSurveyEvent extends Equatable {}

class RouteSurveyPageLoadEvent extends RouteSurveyEvent {
  final BuildContext context;
  RouteSurveyPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends RouteSurveyEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends RouteSurveyEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
class SelectAllCheckBoxEvent extends RouteSurveyEvent {
  final bool isSelected;
  final List<ReportActivityData> list;
  SelectAllCheckBoxEvent({required this.isSelected, required this.list});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected, list];
}

class SelectRowIdCheckBoxEvent extends RouteSurveyEvent {
  final String itemId;
  final bool isSelected;

  SelectRowIdCheckBoxEvent({required this.itemId, required this.isSelected});

  @override
  List<Object> get props => [itemId, isSelected];
}
class ActivityApprovedEvent extends RouteSurveyEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends RouteSurveyEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class DownloadPdfEvent extends RouteSurveyEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends RouteSurveyEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends RouteSurveyEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}