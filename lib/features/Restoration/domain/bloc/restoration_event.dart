part of 'restoration_bloc.dart';

abstract class RestorationEvent extends Equatable {}


class RestorationPageLoadEvent extends RestorationEvent {
  final BuildContext context;
  RestorationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends RestorationEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends RestorationEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAllCheckBoxEvent extends RestorationEvent {
  final bool isSelected;
  final List<ReportActivityData> list;
  SelectAllCheckBoxEvent({required this.isSelected, required this.list});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected, list];
}

class SelectRowIdCheckBoxEvent extends RestorationEvent {
  final String itemId;
  final bool isSelected;

  SelectRowIdCheckBoxEvent({required this.itemId, required this.isSelected});

  @override
  List<Object> get props => [itemId, isSelected];
}

class ActivityApprovedEvent extends RestorationEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends RestorationEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class DownloadPdfEvent extends RestorationEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends RestorationEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends RestorationEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}