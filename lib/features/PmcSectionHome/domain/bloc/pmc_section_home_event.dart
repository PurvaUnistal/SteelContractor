

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PmcSectionHomeEvent extends Equatable {
  const PmcSectionHomeEvent();
}

class PmcSectionHomePageLoadEvent extends PmcSectionHomeEvent {
  final BuildContext context;

  const PmcSectionHomePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class PmcSectionHomePageRefreshEvent extends PmcSectionHomeEvent {
  final BuildContext context;

  const PmcSectionHomePageRefreshEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

