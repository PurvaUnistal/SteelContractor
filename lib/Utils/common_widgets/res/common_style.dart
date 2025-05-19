import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_styles.dart';

import 'environment_config.dart';
import 'singleton.dart';

class CommonStyle {
  static BuildContext? context = Singleton.instanceInit()?.context;

  static LinearGradient gradients = LinearGradient(
    colors: [
      EnvironmentConfig.of(context!)!.secondaryTheme,
      EnvironmentConfig.of(context!)!.primaryTheme,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
        color: EnvironmentConfig.of(context!)!.primaryTheme, style: BorderStyle.solid, width: 0.80),
  );

  static OutlineInputBorder borderGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide:
        BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
  );

  static OutlineInputBorder borderRed = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide:
        BorderSide(color: AppColor.red, style: BorderStyle.solid, width: 0.80),
  );

  static Widget vertical({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }

  static Widget widthSpace({required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.016,
    );
  }

  static DataColumn dataColumn({required String label}) {
    return DataColumn(
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style: Styles.table,
            textAlign: TextAlign.center,
          ),
        ));
  }

  static DataColumn dataCheckBox({required Widget widget}) {
    return DataColumn(
        label:widget );
  }

  static DataCell dataCell({required String label}) {
    return DataCell(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    ));
  }

  static DataCell dataCellG({required String label}) {
    return DataCell(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(label, style: Styles.title,),
    ));
  }


}
