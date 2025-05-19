import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/helper/home_helper.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ActivitySectionData> _listActivityData = [];
  List<ActivitySectionData> get listActivityData => _listActivityData;
  List<ActivitySectionData> _listFilterActivityData = [];
  List<ActivitySectionData> get listFilterActivityData => _listFilterActivityData;

  HomeBloc() : super(HomeInitial()) {
    on<HomePageLoadEvent>(_pageLoad);
  }

  _pageLoad(HomePageLoadEvent event, emit) async {
    emit(HomePageLoadState());
    _listActivityData = [];
    _listFilterActivityData = [];
    _listActivityData =  (await HomeHelper.activityBySectionApi(context: event.context))!;
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<HomeState> emit) {
    emit(FetchHomeDataState(
      listActivityData: listActivityData,
    ));
  }
}
