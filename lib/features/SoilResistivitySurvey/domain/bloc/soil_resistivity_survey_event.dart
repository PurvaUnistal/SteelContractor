part of 'soil_resistivity_survey_bloc.dart';

sealed class SoilResistivitySurveyEvent extends Equatable {}


class SoilResistivitySurveyPageLoadEvent extends SoilResistivitySurveyEvent {
  final BuildContext context;
  SoilResistivitySurveyPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends SoilResistivitySurveyEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends SoilResistivitySurveyEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAllCheckBoxEvent extends SoilResistivitySurveyEvent {
  final bool isSelected;
  final List<ReportActivityData> list;
  SelectAllCheckBoxEvent({required this.isSelected, required this.list});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected, list];
}

class SelectRowIdCheckBoxEvent extends SoilResistivitySurveyEvent {
  final String itemId;
  final bool isSelected;

  SelectRowIdCheckBoxEvent({required this.itemId, required this.isSelected});

  @override
  List<Object> get props => [itemId, isSelected];
}

class ActivityApprovedEvent extends SoilResistivitySurveyEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends SoilResistivitySurveyEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


class DownloadPdfEvent extends SoilResistivitySurveyEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends SoilResistivitySurveyEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends SoilResistivitySurveyEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}