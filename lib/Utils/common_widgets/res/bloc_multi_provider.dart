import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/bloc/approver_activity_bloc.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';
import 'package:steel_contractor/features/Login/domain/bloc/login_bloc.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_bloc.dart';

MultiBlocProvider multiBlocProvider({required Widget child}) {
  return MultiBlocProvider(providers: [
    BlocProvider(create: (BuildContext context) => LoginBloc()),
    BlocProvider(create: (BuildContext context) => HomeBloc()),
    BlocProvider(create: (BuildContext context) => PmcSectionHomeBloc()),
    BlocProvider(create: (BuildContext context) => ApproverActivityBloc()),
  ], child: child);
}
