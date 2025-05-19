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
import 'package:steel_contractor/features/ClearingGrading/domain/model/ActivityApproveRejectModel.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/NDTLPT/domain/bloc/ndt_lpt_bloc.dart';
import 'package:steel_contractor/features/NDTLPT/domain/bloc/ndt_lpt_state.dart';
import 'package:steel_contractor/service/Apis.dart';
import 'package:steel_contractor/service/api_server_dio.dart';

class NDTLPTHelper {

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

  static Future<ActivityApproveRejectModel?> saveActivityApproveReject({
    required BuildContext context,
    required String remark,
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

  static showConfirmationDialog({
    required BuildContext context,
    required emit,
    required bool isApproval,
    required TextEditingController remarksController,
    required Future<void> Function() onConfirm,
  }) async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocBuilder<NDTLPTBloc, NDTLPTState>(
          builder: (context, state) {
            if (state is NDTLPTLoadedDataState) {
              return Material(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Confirm?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          CommonStyle.vertical(context: context),
                          Text(
                            isApproval
                                ? "Are you sure you want to approve this record?"
                                : "Are you sure you want to reject this record?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          CommonStyle.vertical(context: context),
                          if (!isApproval)
                            TextFieldWidget(
                              star: AppString.star,
                              label: AppString.remarks,
                              hintText: AppString.remarks,
                              controller: remarksController,
                            ),
                          CommonStyle.vertical(context: context),
                          state.isBtnLoader
                              ? DottedLoaderWidget()
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if(remarksController.text.isEmpty && !isApproval){
                                    return Utils.errorSnackBar(
                                      msg: "This Remarks is required",
                                      context:context,
                                    );
                                  }
                                  await onConfirm();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
