import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';

abstract class WeldingEvent extends Equatable {}


class WeldingPageLoadEvent extends WeldingEvent {
  final BuildContext context;
  WeldingPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends WeldingEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends WeldingEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
  class SelectAllCheckBoxEvent extends WeldingEvent {
    final bool isSelected;
    final List<ReportActivityData> list;
    SelectAllCheckBoxEvent({required this.isSelected, required this.list});
    @override
    // TODO: implement props
    List<Object> get props => [isSelected, list];
  }

class SelectRowIdCheckBoxEvent extends WeldingEvent {
  final String itemId;
  final bool isSelected;
  final BuildContext context;

  SelectRowIdCheckBoxEvent({
    required this.itemId,
    required this.isSelected,
    required this.context,
  });

  @override
  List<Object> get props => [itemId, isSelected,context];
}



class ActivityApprovedEvent extends WeldingEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends WeldingEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



class DownloadPdfEvent extends WeldingEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends WeldingEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}