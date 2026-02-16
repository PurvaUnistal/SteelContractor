import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(
                    AppConfig.instanceInit()?.loginData.user?.projectLogo ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(
              title ?? "",
              style: Styles.appTitle,
            ),
          ),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.03,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(
                    AppConfig.instanceInit()?.loginData.user?.smartLogo ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // title: Text(
      //   title ?? "",
      //   style: Styles.appTitle,
      // ),
      actions: actions ?? [],
    );
  }
}