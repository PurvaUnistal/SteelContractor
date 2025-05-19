import 'package:equatable/equatable.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/model/SectionIdModel.dart';

abstract class PmcSectionHomeState extends Equatable {
  const PmcSectionHomeState();
}

class PmcSectionHomeInitial extends PmcSectionHomeState {
  @override
  List<Object> get props => [];
}

class PmcSectionHomePageLoadState extends PmcSectionHomeInitial {
  @override
  List<Object> get props => [];
}

class FetchPmcSectionHomeDataState extends PmcSectionHomeInitial {
  final List<SectionIdData> listOfSectionId;

  FetchPmcSectionHomeDataState({
    required this.listOfSectionId,
  });

  @override
  List<Object> get props => [

    listOfSectionId,
      ];
}
