import 'package:flutter/cupertino.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Login/domain/model/login_model.dart';

class AppConfig {
  static AppConfig? instance;

  static AppConfig? instanceInit() {
    instance ??= AppConfig();
    return instance;
  }

  Client? client;
  LoginModel loginData = LoginModel();
  List<ActivitySectionData> listOfActivitySection = [];
  ActivitySectionData activitySectionData =ActivitySectionData();

  String _baseURL = "";
  String get baseURL => _baseURL;

  String _reportActivityId = "";
  String get reportActivityId => _reportActivityId;

  String _buildNumber = "";
  String get buildNumber => _buildNumber;

  String _packageName = "";
  String get packageName => _packageName;


  setClient({required Client client}) {
    this.client = client;
  }
   setBaseURL({required String baseURL}) {
    _baseURL = baseURL;
    print("_baseURL : $_baseURL");
  }


  void setReportActivityId({required String newReportActivityId}) {
    _reportActivityId = newReportActivityId;
    print("newReportActivityId : $newReportActivityId");
  }

  static DeviceType getDeviceType({BuildContext? context}) {
    var isPortrait = true;
    if (context != null) {
      isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    }

/*    final MediaQueryData data = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single);
       return data.size.shortestSide <= 600
        ? DeviceType.phone
        : DeviceType.tablet;*/

    return isPortrait == true ? DeviceType.phone : DeviceType.tablet;
  }
  setLoginData({required LoginModel newLoginData}) {
    this.loginData = newLoginData;
  }


  void setBuildNumber({required String buildNumber}) {
    _buildNumber = buildNumber;
    print("buildNumber : $_buildNumber");
  }

  void setPackageName({required String packageName}) {
    _packageName = packageName;
    print("packageName : $packageName");
  }

  void setActivityData({required ActivitySectionData newActivitySectionData}) {
    activitySectionData = newActivitySectionData;
    print("newActivityData : $newActivitySectionData");
  }

  void setListActivityData({required List<ActivitySectionData> newListOfActivitySection}) {
    listOfActivitySection = newListOfActivitySection;
    print("listOfActivitySection : $newListOfActivitySection");
  }


}