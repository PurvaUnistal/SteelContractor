import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';

abstract class WeldRepairEvent extends Equatable {}


class WeldRepairPageLoadEvent extends WeldRepairEvent {
  final BuildContext context;
  WeldRepairPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends WeldRepairEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends WeldRepairEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
  class SelectAllCheckBoxEvent extends WeldRepairEvent {
    final bool isSelected;
    final List<ReportActivityData> list;
    SelectAllCheckBoxEvent({required this.isSelected, required this.list});
    @override
    // TODO: implement props
    List<Object> get props => [isSelected, list];
  }

class SelectRowIdCheckBoxEvent extends WeldRepairEvent {
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



class ActivityApprovedEvent extends WeldRepairEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends WeldRepairEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



class DownloadPdfEvent extends WeldRepairEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends WeldRepairEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}