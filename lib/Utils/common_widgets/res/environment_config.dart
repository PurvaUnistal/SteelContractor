import 'package:flutter/material.dart';

import 'enums.dart';

class EnvironmentConfig extends InheritedWidget {
  final EnvironmentFlavor flavor;

  EnvironmentConfig({required this.flavor, required super.child});

  static EnvironmentConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw true;
  }

  String get generalUrlBaseFlavour {
    print("flavor-->${flavor}");
    switch (flavor) {
      case EnvironmentFlavor.prodAGCL:
        return "http://agcl.smartgasnet.com/api/";
      case EnvironmentFlavor.prodPBGPL:
        return "http://pbgpldev.smartgasnet.com/api/";
      case EnvironmentFlavor.prodIGL:
        return "https://igl.smartgasnet.com/api/";
      case EnvironmentFlavor.prodMGL:
        return "https://mgldev.smartgasnet.com/api/";
      case EnvironmentFlavor.prodUnistal:
        return "https://unistaldev.plcms.net/api/";
      case EnvironmentFlavor.prodHPOIL:
        return "https://hpoil.smartgasnet.com/api/";
      case EnvironmentFlavor.prodVPPL:
        return "https://vppl.plcms.net/api/";
      case EnvironmentFlavor.prodVRPL:
        return "https://vrpl.plcms.net/api/";
      case EnvironmentFlavor.prodGJPL:
        return "https://gjpl.plcms.net/api/";
      case EnvironmentFlavor.prodJDPL:
        return "https://jdpl.plcms.net/api/";
      case EnvironmentFlavor.prodBRCPL:
        return "https://bcpl.plcms.net/api/";
    }
  }

  Color get primaryTheme {
    switch (flavor) {
      case EnvironmentFlavor.prodAGCL:
        return Colors.blue.shade800;
      case EnvironmentFlavor.prodPBGPL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodIGL:
        return Colors.yellow.shade800;
      case EnvironmentFlavor.prodMGL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodUnistal:
        return Colors.blue.shade800;
      case EnvironmentFlavor.prodHPOIL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodVPPL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodVRPL:
        return Colors.amber.shade400;
      case EnvironmentFlavor.prodGJPL:
        return Colors.green.shade700;
      case EnvironmentFlavor.prodJDPL:
        return Colors.amber.shade400;
      case EnvironmentFlavor.prodBRCPL:
        return Colors.amber.shade400;
    }
  }

  Color get secondaryTheme {
    switch (flavor) {
      case EnvironmentFlavor.prodAGCL:
        return Colors.blue.shade800;
      case EnvironmentFlavor.prodPBGPL:
        return Colors.yellow.shade800;
      case EnvironmentFlavor.prodIGL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodMGL:
        return Colors.yellow.shade800;
      case EnvironmentFlavor.prodUnistal:
        return Colors.blue.shade800;
      case EnvironmentFlavor.prodHPOIL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodVPPL:
        return Colors.green.shade800;
      case EnvironmentFlavor.prodVRPL:
        return Colors.amber.shade400;
      case EnvironmentFlavor.prodGJPL:
        return Colors.green.shade700;
      case EnvironmentFlavor.prodJDPL:
        return Colors.amber.shade400;
      case EnvironmentFlavor.prodBRCPL:
        return Colors.amber.shade400;
    }
  }
}
