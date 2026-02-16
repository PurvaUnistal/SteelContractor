part of 'post_hydrotest_bloc.dart';

abstract class PostHydrotestEvent extends Equatable {}


class PostHydrotestPageLoadEvent extends PostHydrotestEvent {
  final BuildContext context;
  PostHydrotestPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends PostHydrotestEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends PostHydrotestEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


class SelectAllCheckBoxEvent extends PostHydrotestEvent {
  final bool isSelected;
  final List<ReportActivityData> list;
  SelectAllCheckBoxEvent({required this.isSelected, required this.list});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected, list];
}

class SelectRowIdCheckBoxEvent extends PostHydrotestEvent {
  final String itemId;
  final bool isSelected;

  SelectRowIdCheckBoxEvent({required this.itemId, required this.isSelected});

  @override
  List<Object> get props => [itemId, isSelected];
}

class ActivityApprovedEvent extends PostHydrotestEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends PostHydrotestEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


class DownloadPdfEvent extends PostHydrotestEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends PostHydrotestEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends PostHydrotestEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}