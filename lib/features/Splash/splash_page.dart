import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:steel_contractor/Utils/common_widgets/Routes/routes_name.dart';
import 'package:steel_contractor/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:steel_contractor/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_icon.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/features/Login/domain/model/login_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    _getData();
    toLogin();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  Future<LoginModel?> _getData() async {
    try {
      String? userJson = await SharedPref.getString(key: PrefsValue.userInfo ?? "");
      if (userJson != '') {
        Map<String, dynamic> userMap = jsonDecode(userJson!);
        LoginModel loginModel = LoginModel.fromJson(userMap);
        final appConfig = AppConfig.instanceInit();
        if (appConfig != null) {
          await appConfig.setLoginData(newLoginData: loginModel);
        }
        return loginModel;
      }
    } catch (e) {
      debugPrint("Error in _getData: $e");
    }
    return null;
  }

  Future<void> toLogin() async {
    final email = await SharedPref.getString(key: PrefsValue.emailVal);
    final password = await SharedPref.getString(key: PrefsValue.passwordVal);
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final newVersion  = await packageInfo.buildNumber;
    AppConfig.instanceInit()?.setBuildNumber(buildNumber: packageInfo.buildNumber);
    final oldVersion = await SharedPref.getString(key: PrefsValue.buildNumber);
    Timer(
        const Duration(seconds: 3),
            () async {
          if (oldVersion == newVersion) {
            if (email.isNotEmpty || password.isNotEmpty) {
              if(AppConfig.instanceInit()?.loginData.user?.role == "pmc"){
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.sectionIdPage,
                );
              }else{
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.home,
                );
              }
            }
          } else {
            await SharedPref.clearAll();
            Navigator.pushReplacementNamed(
              context,
              RoutesName.login,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppConfig.instanceInit()!.client == Client.agcl
                    ? AppIcon.agclLogo
                    : AppConfig.instanceInit()!.client == Client.purbaBharati
                    ? AppIcon.pbgLogo
                    : AppConfig.instanceInit()!.client == Client.mahaNagar
                    ? AppIcon.mglLogo
                    : AppIcon.pbgLogo,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
          ),
        ));
  }
}