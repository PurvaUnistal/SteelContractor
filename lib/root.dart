import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/bloc_multi_provider.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/singleton.dart';
import 'Utils/common_widgets/Routes/routes.dart';
import 'Utils/common_widgets/Routes/routes_name.dart';

class Root extends StatefulWidget {
  final Client client;
  const Root ({required this.client});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Singleton.instanceInit()?.context = context;
    AppConfig.instanceInit()!.setClient(client: widget.client);
    return multiBlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: EnvironmentConfig.of(context)!.primaryTheme,
              hintColor: EnvironmentConfig.of(context)!.primaryTheme,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: EnvironmentConfig.of(context)!.primaryTheme,)),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,

        ));
  }
}