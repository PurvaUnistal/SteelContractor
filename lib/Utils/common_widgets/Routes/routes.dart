import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/singleton.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/Login/presentation/login_page.dart';
import 'package:steel_contractor/features/PmcSectionHome/presenation/section_id_page.dart';
import 'package:steel_contractor/features/Splash/splash_page.dart';
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
