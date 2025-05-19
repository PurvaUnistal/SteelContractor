import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/features/ClearingGrading/presentation/clearing_grading_page.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/Login/presentation/login_page.dart';
import 'package:steel_contractor/features/OfcBlowing/presentation/ofc_blowing_page.dart';
import 'package:steel_contractor/features/OfcSplicingJointing/presentation/ofc_splicing_jointing_page.dart';
import 'package:steel_contractor/features/PostHydrotest/presentation/post_hydrotest_page.dart';
import 'package:steel_contractor/features/Restoration/presentation/restoration_page.dart';
import 'package:steel_contractor/features/RouHandover/presentation/rou_handover_page.dart';
import 'package:steel_contractor/features/RouteSurvey/presentation/route_survey_page.dart';
import 'package:steel_contractor/features/SoilResistivitySurvey/presentation/soil_resistivity_survey_page.dart';
import 'package:steel_contractor/features/Splash/splash_page.dart';
import 'package:steel_contractor/features/Trenching/presentation/trenching_page.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashPage());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());

        default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }

  static Widget getRouteForActivity(ActivitySectionData data) {
    switch (data.activityName) {
      case AppString.routeSurvey:
        return RouteSurveyPage();
      case AppString.rouHandover:
        return RouHandoverPage();
      case AppString.clearingGrading:
        return ClearingGradingPage();
      case AppString.trenching:
        return TrenchingPage();
      case AppString.ofcSplicing:
        return OfcSplicingJointingPage();
      case AppString.ofcBlowing:
        return OfcBlowingPage();
      case AppString.postHydroTest:
        return PostHydrotestPage();
      case AppString.restoration:
        return RestorationPage();
      case AppString.soilResistivitySurvey:
        return SoilResistivitySurveyPage();
      default:
        return  const Scaffold(
          body: Center(
            child: Text('No route defined'),
          ),
        );
    }
  }


}
