import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_styles.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? boolLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? tabBar;

  const AppBarWidget(
      {Key? key,
        this.title,
        this.leading,
        this.boolLeading,
        this.actions,
        this.tabBar})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: boolLeading ?? false,
      iconTheme: IconThemeData(color: AppColor.white),
      // backgroundColor: AppColor.prime,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[ EnvironmentConfig.of(context)!.secondaryTheme, EnvironmentConfig.of(context)!.primaryTheme,]),
        ),
      ),

      elevation: 0,
      leading: leading,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: Styles.appTitle,
      ),
      actions: actions ?? [],
    );
  }
}