import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';

abstract class ApproverActivityEvent extends Equatable {
  const ApproverActivityEvent();

  @override
  List<Object?> get props => [];
}



class ApproverActivityPageLoadEvent extends ApproverActivityEvent {
  final BuildContext context;
  ApproverActivityPageLoadEvent({required this.context});
  // TODO: implement props
  List<Object> get props => [context];
}

class SearchBpNumberEvent extends ApproverActivityEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends ApproverActivityEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  // TODO: implement props
  List<Object> get props => [context];
}
  class SelectAllCheckBoxEvent extends ApproverActivityEvent {
    final bool isSelected;
    final List<ReportActivityData> list;
    SelectAllCheckBoxEvent({required this.isSelected, required this.list});
    // TODO: implement props
    List<Object> get props => [isSelected, list];
  }

class SelectRowIdCheckBoxEvent extends ApproverActivityEvent {
  final String itemId;
  final bool isSelected;
  final BuildContext context;

  SelectRowIdCheckBoxEvent({
    required this.itemId,
    required this.isSelected,
    required this.context,
  });

  List<Object> get props => [itemId, isSelected,context];
}



class ActivityApprovedEvent extends ApproverActivityEvent {
  final BuildContext context;
  ActivityApprovedEvent({required this.context});
  // TODO: implement props
  List<Object> get props => [ context];
}

class ActivityRejectEvent extends ApproverActivityEvent {
  final BuildContext context;
  ActivityRejectEvent({required this.context});
  // TODO: implement props
  List<Object> get props => [context];
}



class DownloadPdfEvent extends ApproverActivityEvent {
  final String url;
  final BuildContext context;
  DownloadPdfEvent({required this.url,required this.context});
  // TODO: implement props
  List<Object> get props => [url,context];
}

class ImageViewEvent extends ApproverActivityEvent {
  final String url;
  final BuildContext context;
  ImageViewEvent({required this.url,required this.context});
  // TODO: implement props
  List<Object> get props => [url,context];
}

class SelectTpiEvent extends ApproverActivityEvent {
  final TpiModel tpiValue;
  SelectTpiEvent({required this.tpiValue,});
  @override
  // TODO: implement props
  List<Object> get props => [tpiValue];
}