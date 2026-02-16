import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';

abstract class JointCoatingEvent extends Equatable {}


class JointCoatingPageLoadEvent extends JointCoatingEvent {
  final BuildContext context;
  JointCoatingPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends JointCoatingEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends JointCoatingEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
  class SelectAllCheckBoxEvent extends JointCoatingEvent {
    final bool isSelected;
    final List<ReportActivityData> list;
    SelectAllCheckBoxEvent({required this.isSelected, required this.list});
    @override
    // TODO: implement props
    List<Object> get props => [isSelected, list];
  }

class SelectRowIdCheckBoxEvent extends JointCoatingEvent {
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



class ActivityApprovedEvent extends JointCoatingEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends JointCoatingEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



class DownloadPdfEvent extends JointCoatingEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends JointCoatingEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends JointCoatingEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}