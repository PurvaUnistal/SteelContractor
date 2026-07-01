import 'app_config.dart';
import 'enums.dart';

class AppIcon {
  static final Map<Client, String> logos = {
    Client.pbgpl: pbgLogo,
    Client.mgl: mglLogo,
    Client.unistal: unistalLogo,
    Client.hpoil: hpOiLogo,
    Client.vppl: vpplLogo,
    Client.vrpl: vrplLogo,
    Client.gjpl: vpplLogo,
    Client.jdpl: vrplLogo,
    Client.bcpl: vrplLogo,
    Client.agcl: agclBanner,
    Client.dbpl: vrplLogo,
    Client.pgpl: pjplLogo,
    Client.urjagati: urjagatiLogo,
    Client.bjpl: vrplLogo,
    Client.hpcl: hpclLogo,
  };

  static String logo() {
    final client = AppConfig.instanceInit()?.client;
    return logos[client] ?? unistalLogo;
  }
  static const Map<Client, String> domainNames = {
    Client.pbgpl: 'Purba Bharati Gas Pvt. Ltd',
    Client.mgl: 'MahaNagar Gas',
    Client.unistal: 'Unistal System Pvt. Ltd',
    Client.hpoil: 'HPOIL Approver APP',
    Client.vppl: 'VPPL Approver APP',
    Client.vrpl: 'VRPL Approver APP',
    Client.gjpl: 'GJPL Approver APP',
    Client.jdpl: 'JDPL Approver APP',
    Client.bcpl: 'BCPL Approver APP',
    Client.agcl: 'AGCL Approver APP',
    Client.dbpl: 'DBPL Approver APP',
    Client.pgpl: 'PJPL Approver APP',
    Client.urjagati: 'Urjagati Approver APP',
    Client.bjpl: 'BJPL Approver APP',
    Client.hpcl: 'HPCL Approver APP',
  };

  static String domainName() {
    final client = AppConfig.instanceInit()?.client;
    return domainNames[client] ?? 'Unistal System Pvt. Ltd';
  }

  static String agclLogo = 'assets/logo/agcl_logo.png';
  static String agclBanner = 'assets/logo/agcl_banner.png';
  static String agclIcon = 'assets/logo/agcl_icon.png';
  static String pbgLogo = 'assets/logo/pbgpl_logo.png';
  static String unistalLogo = 'assets/logo/unistal_logo.png';
  static String mglLogo = 'assets/logo/mgl_logo.png';
  static String oilIndiaLogo = 'assets/logo/oil_india_logo.png';
  static String hpOiLogo = 'assets/logo/hp_oil_logo.png';
  static String vpplLogo = 'assets/logo/vppl_plcms.png';
  static String vrplLogo = 'assets/logo/vrpl_plcms.png';
  static String hpclLogo = 'assets/logo/hpcl_logo.png';
  static String pjplLogo = 'assets/logo/pjpl_logo.png';
  static String urjagatiLogo = 'assets/logo/urjagati_logo.png';
  static String pdfIcon = 'assets/images/pdf_icon.png';
}
