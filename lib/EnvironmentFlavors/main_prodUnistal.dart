import 'package:flutter/cupertino.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var environmentConfig = EnvironmentConfig(
    flavor: EnvironmentFlavor.prodUnistal,
    child: Root(client: Client.unistal),
  );
  runApp(environmentConfig);
}

