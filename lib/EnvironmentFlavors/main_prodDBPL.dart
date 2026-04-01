import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var environmentConfig = EnvironmentConfig(
    flavor: EnvironmentFlavor.prodDBPL,
    child: Root(client: Client.dbpl),
  );
  runApp(environmentConfig);
}

