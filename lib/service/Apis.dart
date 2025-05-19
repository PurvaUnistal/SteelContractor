import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/singleton.dart';


class Apis {

  static BuildContext? context = Singleton.instanceInit()?.context;

  static final String baseUrl =
      EnvironmentConfig.of(context!)!.generalUrlBaseFlavour;


  static get loginUrl  => "auth";
  static get activityBySection  => "steel/GetActivitybySection?";
  static get reportByActivityId  => "steel/GetReportByActivityId?";
  static get activityApproveRouSurvey  => "steel/activityapproveRouSurvey";
}
