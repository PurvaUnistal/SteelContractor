import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/root.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var environmentConfig = EnvironmentConfig(
    flavor: EnvironmentFlavor.prodBRCPL,
    child: Root(client: Client.brcpl),
  );
  runApp(environmentConfig);
}

