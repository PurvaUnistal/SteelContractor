import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_event.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_state.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/model/SectionIdModel.dart';
import 'package:steel_contractor/features/PmcSectionHome/helper/pmc_section_home_helper.dart';

class PmcSectionHomeBloc extends Bloc<PmcSectionHomeEvent, PmcSectionHomeState> {
  PmcSectionHomeBloc() : super(PmcSectionHomeInitial()) {
    on<PmcSectionHomePageLoadEvent>(_pageLoad);
  }

  List<SectionIdData> listOfSectionId = [];
  _pageLoad(PmcSectionHomePageLoadEvent event, emit) async {
    emit(PmcSectionHomePageLoadState());
    listOfSectionId = [];
    listOfSectionId = (await PmcSectionHomeHelper.pmcReportSectionIdApi(context: event.context))!;
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<PmcSectionHomeState> emit) {
    emit(FetchPmcSectionHomeDataState(
      listOfSectionId: listOfSectionId,
    ));
  }
}
