import 'app_config.dart';
import 'enums.dart';

class AppIcon {
  static logo() {
    return AppConfig.instanceInit()!.client == Client.pbgpl
        ? AppIcon.pbgLogo
        : AppConfig.instanceInit()!.client == Client.mgl
        ? AppIcon.mglLogo
        : AppConfig.instanceInit()!.client == Client.unistal
        ? AppIcon.unistalLogo
        : AppConfig.instanceInit()!.client == Client.hpoil
        ? AppIcon.hpOiLogo
        : AppConfig.instanceInit()!.client == Client.vppl
        ? AppIcon.vpplLogo
        : AppConfig.instanceInit()!.client == Client.vrpl
        ? AppIcon.vrplLogo
        : AppConfig.instanceInit()!.client == Client.gjpl
        ? AppIcon.vpplLogo
        : AppConfig.instanceInit()!.client == Client.jdpl
        ? AppIcon.vrplLogo
        : AppConfig.instanceInit()!.client == Client.brcpl
        ? AppIcon.vrplLogo
        : AppIcon.unistalLogo;
  }

  static domainName() {
    return AppConfig.instanceInit()!.client == Client.pbgpl
        ? 'Purba Bharati Gas Pvt. Ltd'
        : AppConfig.instanceInit()!.client == Client.mgl
        ? 'MahaNagar Gas'
        : AppConfig.instanceInit()!.client == Client.unistal
        ? 'Unistal System Pvt. Ltd'
        : AppConfig.instanceInit()!.client == Client.hpoil
        ? 'HP Oil'
        : AppConfig.instanceInit()!.client == Client.vppl
        ? 'VPPL APP'
        : AppConfig.instanceInit()!.client == Client.vrpl
        ? 'VRPL APP'
        : AppConfig.instanceInit()!.client == Client.gjpl
        ? 'GJPL APP'
        : AppConfig.instanceInit()!.client == Client.jdpl
        ? 'JDPL APP'
        : AppConfig.instanceInit()!.client == Client.brcpl
        ? 'BRCPL APP'
        : 'Unistal System Pvt. Ltd';
  }

  static String agclLogo = 'assets/logo/agcl_logo.png';
  static String agclIcon = 'assets/logo/agcl_icon.png';
  static String pbgLogo = 'assets/logo/pbgpl_logo.png';
  static String unistalLogo = 'assets/logo/unistal_logo.png';
  static String mglLogo = 'assets/logo/mgl_logo.png';
  static String oilIndiaLogo = 'assets/logo/oil_india_logo.png';
  static String hpOiLogo = 'assets/logo/hp_oil_logo.png';
  static String vpplLogo = 'assets/logo/vppl_plcms.png';
  static String vrplLogo = 'assets/logo/vrpl_plcms.png';
  static String pdfIcon = 'assets/images/pdf_icon.png';
}
