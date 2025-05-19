import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_styles.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';

class WaveLoaderWidget extends StatelessWidget {
  const WaveLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Center(
      child: SpinKitWave(
        color: EnvironmentConfig.of(context)!.primaryTheme,
        size: w * 0.12,
      ),
    );
  }
}
