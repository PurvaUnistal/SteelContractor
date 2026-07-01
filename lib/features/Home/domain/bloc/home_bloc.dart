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
    final filteredList = (await HomeHelper.activityBySectionApi(context: event.context))!;

    final seen = <String>{};

    listActivityData = filteredList.where((data) {
      final name = data.modelName?.toString().trim() ?? '';
      if (name.isEmpty || name == '0') return false;
      return seen.add(name); // returns false if already present
    }).toList();
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<HomeState> emit) {
    emit(FetchHomeDataState(
      listActivityData: listActivityData,
    ));
  }
}
