import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart' show ReportActivityData;
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';

abstract class NDTMUTEvent extends Equatable {}


class NDTMUTPageLoadEvent extends NDTMUTEvent {
  final BuildContext context;
  NDTMUTPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends NDTMUTEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends NDTMUTEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
  class SelectAllCheckBoxEvent extends NDTMUTEvent {
    final bool isSelected;
    final List<ReportActivityData> list;
    SelectAllCheckBoxEvent({required this.isSelected, required this.list});
    @override
    // TODO: implement props
    List<Object> get props => [isSelected, list];
  }

class SelectRowIdCheckBoxEvent extends NDTMUTEvent {
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



class ActivityApprovedEvent extends NDTMUTEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends NDTMUTEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



class DownloadPdfEvent extends NDTMUTEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends NDTMUTEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends NDTMUTEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}