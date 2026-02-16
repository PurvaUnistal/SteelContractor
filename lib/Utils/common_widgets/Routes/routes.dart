import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/singleton.dart';
import 'package:steel_contractor/features/Backfilling/presentation/backfilling_page.dart';
import 'package:steel_contractor/features/ClearingGrading/presentation/clearing_grading_page.dart';
import 'package:steel_contractor/features/Crossing/presentation/crossing_page.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/Hydrotest/presentation/hydro_test_page.dart';
import 'package:steel_contractor/features/JointCoating/presentation/joint_coating_page.dart';
import 'package:steel_contractor/features/Levelling/presentation/levelling_page.dart';
import 'package:steel_contractor/features/Login/presentation/login_page.dart';
import 'package:steel_contractor/features/Lowering/presentation/lowering_page.dart';
import 'package:steel_contractor/features/MarkerInstallation/presentation/marker_installation_page.dart';
import 'package:steel_contractor/features/NDTLPT/presentation/ndt_lpt_page.dart';
import 'package:steel_contractor/features/NDTMUT/presentation/ndt_mut_page.dart';
import 'package:steel_contractor/features/NDTRT/presentation/ndt_rt_page.dart';
import 'package:steel_contractor/features/OfcBlowing/presentation/ofc_blowing_page.dart';
import 'package:steel_contractor/features/OfcSplicingJointing/presentation/ofc_splicing_jointing_page.dart';
import 'package:steel_contractor/features/PmcSectionHome/presenation/section_id_page.dart';
import 'package:steel_contractor/features/PostHydrotest/presentation/post_hydrotest_page.dart';
import 'package:steel_contractor/features/Restoration/presentation/restoration_page.dart';
import 'package:steel_contractor/features/RouHandover/presentation/rou_handover_page.dart';
import 'package:steel_contractor/features/RouteSurvey/presentation/route_survey_page.dart';
import 'package:steel_contractor/features/SoilResistivitySurvey/presentation/soil_resistivity_survey_page.dart';
import 'package:steel_contractor/features/Splash/splash_page.dart';
import 'package:steel_contractor/features/TieIn/presentation/tie_in_page.dart';
import 'package:steel_contractor/features/Trenching/presentation/trenching_page.dart';
import 'package:steel_contractor/features/WeldRepair/presentation/weld_repair_page.dart';
import 'package:steel_contractor/features/Welding/presentation/welding_page.dart';
import 'routes_name.dart';

class Routes {
  static BuildContext? context = Singleton.instanceInit()?.context;

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
      case RoutesName.sectionIdPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SectionIdPage());

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
    print("datadata--->${data.modelName}");
    print("AppString.backfilling:--->${AppString.backfilling}");
    switch (data.modelName) {
      case RoutesName.routeSurvey:
        return RouteSurveyPage();
      case RoutesName.rouHandover:
        return RouHandoverPage();
      case RoutesName.clearingGrading:
        return ClearingGradingPage();
      case RoutesName.trenching:
        return TrenchingPage();
      case RoutesName.ofcSplicing:
        return OfcSplicingJointingPage();
      case RoutesName.ofcBlowing:
        return OfcBlowingPage();
      case RoutesName.postHydroTest:
        return PostHydrotestPage();
      case RoutesName.restoration:
        return RestorationPage();
      case RoutesName.soilResistivity:
        return SoilResistivitySurveyPage();
      case RoutesName.backfilling:
        return BackfillingPage();
      case RoutesName.crossing:
        return CrossingPage();
      case RoutesName.hydrotest:
        return HydroTestPage();
      case RoutesName.jointCoating:
        return JointCoatingPage();
      case RoutesName.levelling:
        return CrossingPage();
      case RoutesName.lowering:
        return LoweringPage();
      case RoutesName.marker:
        return MarkerInstallationPage();
      case RoutesName.ndtLpt:
        return NDTLPTPage();
      case RoutesName.ndtmut:
        return NDTMUTPage();
      case RoutesName.ndtrt:
        return NDTRTPage();
      case RoutesName.tiein:
        return TieInPage();
      case RoutesName.welding:
        return WeldingPage();
      case RoutesName.weldRepair:
        return WeldRepairPage();
      default:
        return  const Scaffold(
          body: Center(
            child: Text('No route defined'),
          ),
        );
    }
  }

  static navigationToNextPage() async {
    Navigator.of(context!).pop();
    Navigator.of(context!).pop();
   /* Navigator.pushAndRemoveUntil(
      context!, new MaterialPageRoute(builder: (context) =>
    new HomePage()),
          (Route<dynamic> route) => false,//
    );*/
    /*
      1- use Navigator to switch between routes or activities in Flutter app,
      2- Navigator.push : to push to new route or activity
      3- we called Navigator.pushAndRemoveUntil to pus to the next Route,which is in this case 'secondPage'
      Note: we used pushAndRemoveUntil to push the given route onto navigator and remove all the previous routes from stack or
      until the predicate returns true.

     */
  }
}
