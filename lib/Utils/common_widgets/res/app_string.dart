import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';

class AppString {

  static const Map<Client, String> _releaseDates = {
    Client.mahaNagar: "11-06-2025",
    Client.purbaBharati: "11-06-2025",
    Client.unistal: "11-06-2025",
    Client.oilIndia: "16-02-2026",
    Client.vppl: "28-01-2026",
    Client.vrpl: "17-02-2026",
  };

  static String get version => "Version : 1.0.0 - Steel Contractor-${_releaseDates[AppConfig.instanceInit()!.client] ?? ""}";
  static String companyName = "© Unistal Systems Pvt. Ltd.";
  static String dateFormat = "dd-MM-yyyy";
  static String emailLabel = "Enter User Email";
  static String passwordLabel = "Enter User Password";
  static String emailValidation = "Please enter email id";
  static String passwordValidation = "Please enter password";
  static String submit = "Submit";
  static String yes = "Yes";
  static String no = "No";
  static String login = "Login";
  static String cancel = "cancel";
  static String logout = "Logout";
  static String logoutMsg =
      "Are you sure you want to logout? Once you logout, you will be return to login screen";
  static String acceptedMsg = "Are you sure!";
  static String star = "* ";
  static const String photo = 'Photo';
  static const String appName = 'Steel Contractor APP';
  static const String dashboard = 'Dashboard';
  static const String routeSurvey = 'Route Survey';
  static const String rouHandover = 'Rou Handover';
  static const String clearingGrading = 'CLEARING  GRADING';
  static const String trenching = 'TRENCHING';
  static const String welding = 'Welding';
  static const String lowering = 'Lowering';
  static const String backfilling = 'Backfilling';
  static const String crossing = 'Crossing';
  static const String markerInstallation = 'Marker Installation';
  static const String hydroTest = 'Hydro Test';
  static const String levelling = 'Levelling';
  static const String jointCoating = 'Joint Coating';
  static const String nDTMUT = 'NDT MUT';
  static const String nDTLPT = 'NDT LPT';
  static const String nDTRT = 'NDT RT';
  static const String weldRepair = 'Weld Repair';
  static const String tieIn = 'Tie in';
  static const String ofcSplicing = 'OFC Splicing/Jointing';
  static const String ofcBlowing = 'OFC Blowing';
  static const String postHydroTest = 'Post Hydro Test';
  static const String restoration = 'Restoration';
  static const String soilResistivitySurvey = 'Soil Resistivity Survey';
  static const String reportNumber = 'Report Number';
  static const String remarks = 'remarks';
  static const String sure = 'Are you sure?';
  static const String reject = 'Reject';
  static const String approve = 'Approve';
  static const String approveRejectMsg =
      'Do you want to approve or reject this activity?';
  ////////////////////////////////////////////////


  static get hdd => "HDD";
  static get pilotDrill => "Drilling";
  static get hddReaming => "Reaming";
  static get hddBore => "HDD Bore";
  static get hddCleanPass => "HDD Clean Pass";
  static get hddPulling => "HDD Pulling";
  static get hddCrossing => "HDD Crossing";
  static get gauging => "Gauging";
  static get molling => "Molling";
  static get tcp => "TCP";
  static get testStationBoxes => "Test Station Boxes";
  static get sacrificialAnode => "COMMISSIONING OF SACRIFICIAL ANODES";
  static get groundingAnode => "ZN GROUNDING ANODE/CELL";
  static get installationCables => "INSTALLATION OF CABLES";
  static get mgAnodeInstallation => "Mg Anode Installation";
  static get anodeBedInstallation => "PCP Anode Bed Installation";
  static get cableLaying => "Cable Laying";
  static get thermitWelding => "Thermit Welding";
  static get pinBrazzing => "Pin Brazzing";
  static get ssd => "SSD";
  static get surgeDiverter => "Surge Diverter";
  static get polarisationCoupan => "Polarisation Coupan";
  static get tcpMonitoringReport => "TCP Monitoring Report";
}
