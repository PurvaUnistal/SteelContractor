import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/bloc/clearing_grading_bloc.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';
import 'package:steel_contractor/features/Login/domain/bloc/login_bloc.dart';
import 'package:steel_contractor/features/OfcBlowing/domain/bloc/ofc_blowing_bloc.dart';
import 'package:steel_contractor/features/OfcSplicingJointing/domain/bloc/ofc_splicing_jointing_bloc.dart';
import 'package:steel_contractor/features/PostHydrotest/domain/bloc/post_hydrotest_bloc.dart';
import 'package:steel_contractor/features/RouHandover/domain/bloc/rou_handover_bloc.dart';
import 'package:steel_contractor/features/RouteSurvey/domain/bloc/route_survey_bloc.dart';
import 'package:steel_contractor/features/SoilResistivitySurvey/domain/bloc/soil_resistivity_survey_bloc.dart';
import 'package:steel_contractor/features/Trenching/domain/bloc/trenching_bloc.dart';

import '../../../features/Restoration/domain/bloc/restoration_bloc.dart';

MultiBlocProvider multiBlocProvider({required Widget child}) {
  return MultiBlocProvider(providers: [
    BlocProvider(create: (BuildContext context) => LoginBloc()),
    BlocProvider(create: (BuildContext context) => HomeBloc()),
    BlocProvider(create: (BuildContext context) => ClearingGradingBloc()),
    BlocProvider(create: (BuildContext context) => OfcBlowingBloc()),
    BlocProvider(create: (BuildContext context) => OfcSplicingJointingBloc()),
    BlocProvider(create: (BuildContext context) => PostHydrotestBloc()),
    BlocProvider(create: (BuildContext context) => RestorationBloc()),
    BlocProvider(create: (BuildContext context) => RouHandoverBloc()),
    BlocProvider(create: (BuildContext context) => RouteSurveyBloc()),
    BlocProvider(create: (BuildContext context) => SoilResistivitySurveyBloc()),
    BlocProvider(create: (BuildContext context) => TrenchingBloc()),
  ], child: child);
}
