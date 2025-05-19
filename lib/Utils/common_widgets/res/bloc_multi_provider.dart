import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/Backfilling/domain/bloc/backfilling_bloc.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/bloc/clearing_grading_bloc.dart';
import 'package:steel_contractor/features/Crossing/domain/bloc/crossing_bloc.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';
import 'package:steel_contractor/features/Hydrotest/domain/bloc/hydro_test_bloc.dart';
import 'package:steel_contractor/features/JointCoating/domain/bloc/joint_coating_bloc.dart';
import 'package:steel_contractor/features/Levelling/domain/bloc/levelling_bloc.dart';
import 'package:steel_contractor/features/Login/domain/bloc/login_bloc.dart';
import 'package:steel_contractor/features/Lowering/domain/bloc/lowering_bloc.dart';
import 'package:steel_contractor/features/MarkerInstallation/domain/bloc/marker_installation_bloc.dart';
import 'package:steel_contractor/features/NDTLPT/domain/bloc/ndt_lpt_bloc.dart';
import 'package:steel_contractor/features/NDTMUT/domain/bloc/ndt_mut_bloc.dart';
import 'package:steel_contractor/features/NDTRT/domain/bloc/ndt_rt_bloc.dart';
import 'package:steel_contractor/features/OfcBlowing/domain/bloc/ofc_blowing_bloc.dart';
import 'package:steel_contractor/features/OfcSplicingJointing/domain/bloc/ofc_splicing_jointing_bloc.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_bloc.dart';
import 'package:steel_contractor/features/PostHydrotest/domain/bloc/post_hydrotest_bloc.dart';
import 'package:steel_contractor/features/Restoration/domain/bloc/restoration_bloc.dart';
import 'package:steel_contractor/features/RouHandover/domain/bloc/rou_handover_bloc.dart';
import 'package:steel_contractor/features/RouteSurvey/domain/bloc/route_survey_bloc.dart';
import 'package:steel_contractor/features/SoilResistivitySurvey/domain/bloc/soil_resistivity_survey_bloc.dart';
import 'package:steel_contractor/features/TieIn/domain/bloc/tie_in_bloc.dart';
import 'package:steel_contractor/features/Trenching/domain/bloc/trenching_bloc.dart';
import 'package:steel_contractor/features/WeldRepair/domain/bloc/weld_repair_bloc.dart';
import 'package:steel_contractor/features/Welding/domain/bloc/welding_bloc.dart';

MultiBlocProvider multiBlocProvider({required Widget child}) {
  return MultiBlocProvider(providers: [
    BlocProvider(create: (BuildContext context) => LoginBloc()),
    BlocProvider(create: (BuildContext context) => HomeBloc()),
    BlocProvider(create: (BuildContext context) => PmcSectionHomeBloc()),
    BlocProvider(create: (BuildContext context) => ClearingGradingBloc()),
    BlocProvider(create: (BuildContext context) => OfcBlowingBloc()),
    BlocProvider(create: (BuildContext context) => OfcSplicingJointingBloc()),
    BlocProvider(create: (BuildContext context) => PostHydrotestBloc()),
    BlocProvider(create: (BuildContext context) => RestorationBloc()),
    BlocProvider(create: (BuildContext context) => RouHandoverBloc()),
    BlocProvider(create: (BuildContext context) => RouteSurveyBloc()),
    BlocProvider(create: (BuildContext context) => SoilResistivitySurveyBloc()),
    BlocProvider(create: (BuildContext context) => TrenchingBloc()),
    BlocProvider(create: (BuildContext context) => WeldRepairBloc()),
    BlocProvider(create: (BuildContext context) => WeldingBloc()),
    BlocProvider(create: (BuildContext context) => TieInBloc()),
    BlocProvider(create: (BuildContext context) => NDTRTBloc()),
    BlocProvider(create: (BuildContext context) => NDTMUTBloc()),
    BlocProvider(create: (BuildContext context) => NDTLPTBloc()),
    BlocProvider(create: (BuildContext context) => MarkerInstallationBloc()),
    BlocProvider(create: (BuildContext context) => LoweringBloc()),
    BlocProvider(create: (BuildContext context) => LevellingBloc()),
    BlocProvider(create: (BuildContext context) => JointCoatingBloc()),
    BlocProvider(create: (BuildContext context) => HydroTestBloc()),
    BlocProvider(create: (BuildContext context) => CrossingBloc()),
    BlocProvider(create: (BuildContext context) => BackfillingBloc()),
  ], child: child);
}
