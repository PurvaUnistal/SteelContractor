import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/service/Apis.dart';
import 'package:steel_contractor/service/api_server_dio.dart';

class HomeHelper {

  static Future<List<ActivitySectionData>?> activityBySectionApi({
    required BuildContext context,
  }) async {
    try {
      String schema =
          await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
      String userId = await AppConfig.instanceInit()?.loginData.user?.id ?? "";
      String sectionId = await AppConfig.instanceInit()?.sectionId ?? "";
      Map<String, String> para = {"schema": schema, "userid": userId, "section_id" : sectionId};
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(
        urlEndPoint: Apis.activityBySection + json,
        context: context,
      );
      ActivitySectionModel response = ActivitySectionModel.fromJson(res);
      if(response.data != null){
        AppConfig.instanceInit()?.setListActivityData(newListOfActivitySection: response.data!);
        return response.data;
      }
    } catch (e) {
      log("activityBySection-->${e.toString()}");
    }
    return null;
  }


}
