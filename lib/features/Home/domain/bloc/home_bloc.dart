import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/helper/home_helper.dart';
import 'package:steel_contractor/features/Login/domain/model/login_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  LoginModel _userData = AppConfig.instance!.loginData;

  LoginModel get userData => _userData;


  List<ActivitySectionData> _listActivityData = [];
  List<ActivitySectionData> get listActivityData => _listActivityData;




  HomeBloc() : super(HomeInitial()) {
    on<HomePageLoadEvent>(_pageLoad);
  }

  _pageLoad(HomePageLoadEvent event, emit) async {
    emit(HomePageLoadState());
    _userData = AppConfig.instance!.loginData;
    _listActivityData = (await HomeHelper.activityBySectionApi(context: event.context))!;
    _eventCompleted(emit);
  }



  _eventCompleted(Emitter<HomeState> emit) {
    emit(FetchHomeDataState(
      listActivityData: listActivityData,
    ));
  }
}
