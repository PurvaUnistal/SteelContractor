import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivityApproveRejectModel.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';
import 'package:steel_contractor/service/Apis.dart';
import 'package:steel_contractor/service/api_server_dio.dart';

class HomeHelper {

  static Future<List<ActivitySectionData>?> activityBySectionApi({required BuildContext context,
  }) async {
    try {
      String schema = await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
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

  static Future<ReportActivityModel?> reportByActivityIdAPI({
    required BuildContext context,
  }) async {
    try {
      String schema = await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
      String usedId = await AppConfig.instanceInit()?.loginData.user?.id ?? "";
      String role = await AppConfig.instanceInit()?.loginData.user?.role ?? "";
      ActivitySectionData? activityData = await AppConfig.instanceInit()?.activitySectionData;
      Map<String, String> para = {
        "schema": schema,
        "userid": usedId,
        "activityid": activityData?.activityId ?? "",
        "role": role,
        "spread_id": activityData?.spreadId ?? "",
        "section_id": activityData?.sectionId ?? "",
        "modelName": activityData?.modelName ?? "",
      };
      String json = Uri(queryParameters: para).query;
      print("para--->${para}");
      var res = await ApiHelper.getData(
        urlEndPoint: Apis.reportByActivityId + json,
        context: context,
      );
      ReportActivityModel response = ReportActivityModel.fromJson(res);
      if (response.data != null) {
        return response;
      }
    } catch (e) {
      log("activityBySection-->${e.toString()}");
    }
    return null;
  }

  static Future<List<TpiModel>?> tpiApi({required BuildContext context}) async {
    try {
      String schema = await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
      String role = await AppConfig.instanceInit()?.loginData.user?.role ?? "";
      Map<String, String> para = {
        "schema": schema,
        "role" : role
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.tpiApi + json, context: context,);
      if (res["error"] == false && res["data"] is List) {
        return (res["data"] as List)
            .map((e) => TpiModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      else if(res["data"] != null && res["error"] == true){
        return res["data"];
      }else{
        return null;
      }
    } catch (e) {
      log("tpiApi-->${e.toString()}");
    }
    return null;
  }


  static Future<ActivityApproveRejectModel?> saveActivityApproveReject({
    required BuildContext context,
    required String remark,
    required TpiModel tpiValue,
    required String status,
  }) async {
    String schema = await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
    String userId = await AppConfig.instanceInit()?.loginData.user?.id ?? "";
    String role = await AppConfig.instanceInit()?.loginData.user?.role ?? "";
    ActivitySectionData? activityData = await AppConfig.instanceInit()?.activitySectionData;
    String? reportActivityId = await AppConfig.instanceInit()?.reportActivityId;
    try {
      Map<String, String> para = {
        "schema": schema,
        "id": reportActivityId ?? "",
        "modelName": activityData?.modelName ?? "",
        "status": status,
        "userid": userId,
        "role": role,
        "remark": remark,
        "assign_user_id": tpiValue.iD != null ? tpiValue.iD.toString() : "",
      };
      log("para-->${para}");
      var res = await ApiHelper.postData(urlEndPoint: Apis.activityApproveRouSurvey, formData: para, context: context);
      if (res != null && res["error"] == false) {
        Utils.successSnackBar(msg: res["data"], context: context);
        return ActivityApproveRejectModel.fromJson(res);
      } else if (res != null && res["error"] == true) {
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
    } catch (e) {
      log("saveLmcFeasibility-->${e.toString()}");
      return null;
    }
    return null;
  }

}
