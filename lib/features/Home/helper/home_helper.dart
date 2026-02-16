import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/features/Backfilling/presentation/backfilling_page.dart';
import 'package:steel_contractor/features/ClearingGrading/domain/model/ActivityApproveRejectModel.dart';
import 'package:steel_contractor/features/ClearingGrading/presentation/clearing_grading_page.dart';
import 'package:steel_contractor/features/Crossing/presentation/crossing_page.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/domain/model/drawer_model.dart';
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/Home/presentation/widget/phone_home_widget.dart';
import 'package:steel_contractor/features/JointCoating/presentation/joint_coating_page.dart';
import 'package:steel_contractor/features/Lowering/presentation/lowering_page.dart';
import 'package:steel_contractor/features/MarkerInstallation/presentation/marker_installation_page.dart';
import 'package:steel_contractor/features/NDTLPT/presentation/ndt_lpt_page.dart';
import 'package:steel_contractor/features/NDTMUT/presentation/ndt_mut_page.dart';
import 'package:steel_contractor/features/OfcBlowing/presentation/ofc_blowing_page.dart';
import 'package:steel_contractor/features/PostHydrotest/presentation/post_hydrotest_page.dart';
import 'package:steel_contractor/features/Restoration/presentation/restoration_page.dart';
import 'package:steel_contractor/features/RouHandover/presentation/rou_handover_page.dart';
import 'package:steel_contractor/features/RouteSurvey/presentation/route_survey_page.dart';
import 'package:steel_contractor/features/SoilResistivitySurvey/presentation/soil_resistivity_survey_page.dart';
import 'package:steel_contractor/features/TieIn/presentation/tie_in_page.dart';
import 'package:steel_contractor/features/Trenching/presentation/trenching_page.dart';
import 'package:steel_contractor/features/WeldRepair/presentation/weld_repair_page.dart';
import 'package:steel_contractor/features/Welding/presentation/welding_page.dart';
import 'package:steel_contractor/service/Apis.dart';
import 'package:steel_contractor/service/api_server_dio.dart';

class HomeHelper {

  /* ===================== DRAWER ===================== */

  static Future<List<DrawerModel>?> fetchDrawerList({
    required BuildContext context,
  }) async {
    try {
      final drawerList = <DrawerModel>[];
      final activities = AppConfig.instanceInit()?.listOfActivitySection ?? [];

      final activeActivities = activities.where((e) => e.status == "1").toList();

      drawerList.add(
        DrawerModel(
          widget: const PhoneHomeWidget(),
          icon: Icons.home_outlined,
          label: AppString.dashboard,
          sublist: [],
          isSelected: true,
        ),
      );

      final mainlineSubItems = <DrawerSubModel>[];
      final tcpSubItems = <DrawerSubModel>[];
      final hddSubItems = <DrawerSubModel>[];

      const mainlineModels = [
        "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",
        "16","17","18","19","20","21","22","23","24","25","26","27","30",
        "32","33","52","56","59","60","61",
      ];

      const tcpModels = [
        "28","29","31","40","41","42","43","44","45","46","54","66","68","75","76",
      ];

      const hddModels = [
        "34","35","36","37","38","39","57","73",
      ];

      for (final item in activeActivities) {
        final model = item.activityId?.toString() ?? "";

        if (mainlineModels.contains(model)) {
          mainlineSubItems.addAll(_mainlineSublist(model));
        }

        if (tcpModels.contains(model)) {
          tcpSubItems.addAll(_tcpSublist(model));
        }

        if (hddModels.contains(model)) {
          hddSubItems.addAll(_hddSublist(model));
        }
      }

      if (mainlineSubItems.isNotEmpty) {
        drawerList.add(_groupItem(
            "Mainline", Icons.alt_route, mainlineSubItems));
      }

      if (tcpSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem("TCP", Icons.table_chart_outlined, tcpSubItems));
      }

      if (hddSubItems.isNotEmpty) {
        drawerList.add(
            _groupItem("HDD", Icons.hd_outlined, hddSubItems));
      }

      return drawerList;
    } catch (_) {
      return null;
    }
  }

  /* ===================== SUBLIST BUILDERS ===================== */

  static List<DrawerSubModel> _mainlineSublist(String model) {
    switch (model) {
      case "1":
        return [_sub(AppString.routeSurvey, const RouteSurveyPage())];
      case "2":
        return [_sub(AppString.rouHandover, const RouHandoverPage())];
      case "3":
        return [_sub(AppString.clearingGrading, const ClearingGradingPage())];
      case "4":
        return [_sub("Trenching", const TrenchingPage())];
      case "5":
        return [_sub("Stringing", Center(child: Text("Stringing Page not Found"),))];
      case "6":
        return [_sub("Bending", const OfcBlowingPage())];
      case "7":
        return [_sub(AppString.welding, const WeldingPage())];
      case "8":
        return [_sub(AppString.weldRepair, const WeldRepairPage())];
      case "9":
        return [_sub("NDT Aut", Center(child: Text("NDT Aut Page not Found"),))];
      case "10":
        return [_sub("Radiography", Center(child: Text("Radiography Page not Found"),))];
      case "11":
        return [_sub("NDT Mut", const NDTMUTPage())];
      case "12":
        return [_sub("LPT", const NDTLPTPage())];
      case "13":
        return [_sub(AppString.jointCoating, const JointCoatingPage())];
      case "14":
        return [_sub("Concrete Coating",Center(child: Text("Concrete Coating Page not Found"),))];
      case "15":
        return [_sub(AppString.lowering, const LoweringPage())];
      case "16":
        return [_sub(AppString.crossing, const CrossingPage())];
      case "17":
        return [_sub(AppString.levelling, Center(child: Text("levelling Page not Found"),))];
      case "18":
        return [_sub("BackFilling", const BackfillingPage())];
      case "19":
        return [_sub("HDPE Duct Laying", Center(child: Text("HDPE Duct Laying Page not Found"),))];
      case "20":
        return [_sub("HDPE Duct Testing", Center(child: Text("HDPE Duct Testing Page not Found"),))];
      case "21":
        return [_sub(AppString.ofcSplicing, const OfcBlowingPage())];
      case "22":
        return [_sub(AppString.ofcBlowing, const OfcBlowingPage())];
      case "23":
        return [_sub("Pre Hydro-test", Center(child: Text("Pre Hydro-test Page not Found"),))];
      case "24":
        return [_sub("Post Hydro-test", PostHydrotestPage())];
      case "25":
        return [_sub("Hydro-test", Center(child: Text("Hydro-test Page not Found"),))];
      case "26":
        return [_sub(AppString.restoration, const RestorationPage())];
      case "27":
        return [_sub("Marker", const MarkerInstallationPage())];
      case "30":
        return [_sub("Soil Resistivity", const SoilResistivitySurveyPage())];
      case "32":
        return [_sub("Tie In", const TieInPage())];
      case "33":
        return [_sub("Total Weld Joints", Center(child: Text("Total Weld Joints Page not Found"),))];
      case "52":
        return [_sub("DPT", Center(child: Text("DPT Page not Found"),))];
      case "56":
        return [_sub("Hindrance", Center(child: Text("Hindrance Page not Found"),))];
      case "59":
        return [_sub("Ofc Final Testing", Center(child: Text("Ofc Final Testing Page not Found"),))];
      case "60":
        return [_sub("SV Installation", Center(child: Text("SV Installation Page not Found"),))];
      case "61":
        return [_sub("IP Installation", Center(child: Text("IP Installation Page not Found"),))];
      default:
        return [];
    }
  }

  static List<DrawerSubModel> _tcpSublist(String model) {
    switch (model) {
      case "28":
        return [_sub(AppString.sacrificialAnode, Center(child: Text("${AppString.sacrificialAnode} Page not Found"),))];
      case "29":
        return [_sub(AppString.sacrificialAnode, Center(child: Text("${AppString.sacrificialAnode} Page not Found"),))];
      case "31":
        return [_sub(AppString.installationCables, Center(child: Text("${AppString.installationCables} Page not Found"),))];
      case "40":
        return [_sub(AppString.pinBrazzing, Center(child: Text("${AppString.pinBrazzing} Page not Found"),))];
      case "41":
        return [_sub(AppString.mgAnodeInstallation,Center(child: Text("${AppString.mgAnodeInstallation} Page not Found"),))];
      case "42":
        return [_sub(AppString.anodeBedInstallation, Center(child: Text("${AppString.anodeBedInstallation} Page not Found"),))];
      case "43":
        return [_sub(AppString.cableLaying, Center(child: Text("${AppString.cableLaying} Page not Found"),))];
      case "44":
        return [_sub(AppString.groundingAnode, Center(child: Text("${AppString.groundingAnode} Page not Found"),))];
      case "45":
        return [_sub(AppString.testStationBoxes, Center(child: Text("${AppString.testStationBoxes} Page not Found"),))];
      case "46":
        return [_sub(AppString.thermitWelding,  Center(child: Text("${AppString.thermitWelding} Page not Found"),))];
      case "54":
        return [_sub(AppString.ssd,  Center(child: Text("${AppString.ssd} Page not Found"),))];
      case "66":
        return [_sub(AppString.surgeDiverter, Center(child: Text("${AppString.surgeDiverter} Page not Found"),))];
      case "68":
        return [_sub(AppString.polarisationCoupan, Center(child: Text("${AppString.polarisationCoupan} Page not Found"),))];
      case "75":
        return [_sub(AppString.sacrificialAnode, Center(child: Text("${AppString.sacrificialAnode} Page not Found"),))];
      case "76":
        return [_sub(AppString.tcpMonitoringReport, Center(child: Text("${AppString.tcpMonitoringReport} Page not Found"),))];
      default:
        return [];
    }
  }

  static List<DrawerSubModel> _hddSublist(String model) {
    switch (model) {
      case "34":
        return [_sub(AppString.hddReaming, Center(child: Text("${AppString.hddReaming} Page not Found"),))];
      case "35":
        return [_sub(AppString.pilotDrill, Center(child: Text("${AppString.pilotDrill} Page not Found"),))];
      case "36":
        return [_sub(AppString.hddBore,  Center(child: Text("${AppString.hddBore} Page not Found"),))];
      case "37":
        return [_sub(AppString.hddPulling, Center(child: Text("${AppString.hddPulling} Page not Found"),))];
      case "38":
        return [_sub(AppString.gauging,  Center(child: Text("${AppString.gauging} Page not Found"),))];
      case "39":
        return [_sub(AppString.molling, Center(child: Text("${AppString.molling} Page not Found"),))];
      case "57":
        return [_sub(AppString.hddCleanPass, Center(child: Text("${AppString.hddCleanPass} Page not Found"),))];
      case "73":
        return [_sub(AppString.hddCrossing, Center(child: Text("${AppString.hddCrossing} Page not Found"),))];
      default:
        return [];
    }
  }

  /* ===================== HELPERS ===================== */

  static DrawerModel _groupItem(String label, IconData icon, List<DrawerSubModel> sublist) {
    return DrawerModel(
      widget: const SizedBox.shrink(),
      icon: icon,
      label: label,
      sublist: sublist,
      isSelected: false,
    );
  }

  static DrawerSubModel _sub(String label, Widget page) {
    return DrawerSubModel(
      label: label,
      widget: page,
      isSelected: false,
    );
  }


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
