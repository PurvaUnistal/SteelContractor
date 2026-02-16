import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_event.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_state.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/model/SectionIdModel.dart';
import 'package:steel_contractor/features/PmcSectionHome/helper/pmc_section_home_helper.dart';

class PmcSectionHomeBloc extends Bloc<PmcSectionHomeEvent, PmcSectionHomeState> {
  PmcSectionHomeBloc() : super(PmcSectionHomeInitial()) {
    on<PmcSectionHomePageLoadEvent>(_pageLoad);
  }

  SectionIdModel sectionIdModel = SectionIdModel();
  List<SectionIdData> listOfSectionId = [];

  _pageLoad(PmcSectionHomePageLoadEvent event, emit) async {
    emit(PmcSectionHomePageLoadState());
    sectionIdModel = SectionIdModel();
    listOfSectionId = [];
    var res = await PmcSectionHomeHelper.pmcReportSectionIdApi(context: event.context);
    if(res != null){
      sectionIdModel = res;
      if(res.data!= null && res.data is List){
        listOfSectionId = res.data;
      }
    }
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<PmcSectionHomeState> emit) {
    emit(FetchPmcSectionHomeDataState(
      sectionIdModel: sectionIdModel,
      listOfSectionId: listOfSectionId,
    ));
  }
}
