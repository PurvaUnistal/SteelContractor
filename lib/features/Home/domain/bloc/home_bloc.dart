import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/helper/home_helper.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ActivitySectionData> listActivityData = [];


  HomeBloc() : super(HomeInitial()) {
    on<HomePageLoadEvent>(_pageLoad);
  }

  _pageLoad(HomePageLoadEvent event, emit) async {
    emit(HomePageLoadState());
    listActivityData = [];
    final filteredList =  (await HomeHelper.activityBySectionApi(context: event.context))!;
    listActivityData = filteredList.where((data) {
      return data.modelName != null &&
          data.modelName.toString().trim().isNotEmpty &&
          data.modelName != "0";
    }).toList();
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<HomeState> emit) {
    emit(FetchHomeDataState(
      listActivityData: listActivityData,
    ));
  }
}
