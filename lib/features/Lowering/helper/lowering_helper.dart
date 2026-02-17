import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:steel_contractor/Utils/common_widgets/Routes/routes.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/common_style.dart';
import 'package:steel_contractor/Utils/common_widgets/text_form_widget.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivityApproveRejectModel.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Lowering/domain/bloc/lowering_bloc.dart';
import 'package:steel_contractor/features/Lowering/domain/bloc/lowering_state.dart';
import 'package:steel_contractor/service/Apis.dart';
import 'package:steel_contractor/service/api_server_dio.dart';

class LoweringHelper {

  static Future<ReportActivityModel?> reportByActivityIdAPI({
    required BuildContext context,
  }) async {
    try {
      String schema = await AppConfig.instanceInit()?.loginData.user?.schema ?? "";
      String role = await AppConfig.instanceInit()?.loginData.user?.role ?? "";
      ActivitySectionData? activityData = await AppConfig.instanceInit()?.activitySectionData;
      Map<String, String> para = {
        "schema": schema,
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
}
