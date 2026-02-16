import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/model/SectionIdModel.dart';
import 'package:steel_contractor/service/Apis.dart';
import 'package:steel_contractor/service/api_server_dio.dart';

class PmcSectionHomeHelper {


  static Future<SectionIdModel?> pmcReportSectionIdApi({
    required BuildContext context,
  }) async {
  //  try {
      String schema = await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
      String userId = await AppConfig.instanceInit()?.loginData.user?.id ?? "";
      Map<String, String> para = {"schema": schema, "userid": userId};
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(
        urlEndPoint: Apis.pmcReportSectionId + json,
        context: context,
      );
      if(res != null ){
        return SectionIdModel.fromJson(res);
      }
    // } catch (e) {
    //   log("SectionIdModel-->${e.toString()}");
    // }
    return null;
  }
}
