part of 'trenching_bloc.dart';

abstract class TrenchingEvent extends Equatable {}


class TrenchingPageLoadEvent extends TrenchingEvent {
  final BuildContext context;
  TrenchingPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends TrenchingEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends TrenchingEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAllCheckBoxEvent extends TrenchingEvent {
  final bool isSelected;
  final List<ReportActivityData> list;
  SelectAllCheckBoxEvent({required this.isSelected, required this.list});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected, list];
}

class SelectRowIdCheckBoxEvent extends TrenchingEvent {
  final String itemId;
  final bool isSelected;

  SelectRowIdCheckBoxEvent({required this.itemId, required this.isSelected});

  @override
  List<Object> get props => [itemId, isSelected];
}

class ActivityApprovedEvent extends TrenchingEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends TrenchingEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


class DownloadPdfEvent extends TrenchingEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends TrenchingEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}