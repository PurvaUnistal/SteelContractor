import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_styles.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/features/Home/presentation/widget/app_bar_btn.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? boolLeading;
  final List<Widget>? actions;
  final Widget? tabBar;

  const AppBarWidget({
    Key? key,
    this.title,
    this.boolLeading,
    this.actions,
    this.tabBar,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final bool showBack = boolLeading ?? false;

    return AppBar(
      automaticallyImplyLeading: false,  // always off — we manage leading manually
      iconTheme: IconThemeData(color: AppColor.white),
     // iconTheme: IconThemeData(color: EnvironmentConfig.of(context)!.primaryTheme),
      flexibleSpace: Container(
        decoration: BoxDecoration(
        //  color: AppColor.surface,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              EnvironmentConfig.of(context)!.secondaryTheme,
              EnvironmentConfig.of(context)!.primaryTheme,
            ],
          ),
        ),
      ),
      elevation: 0,
      leading: showBack
          ? AppBarBtn(
        icon: Icons.arrow_back_ios_rounded,
        onTap: () => Navigator.maybePop(context),
      )
          : const SizedBox.shrink(),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Project logo
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
          // Page title
          Flexible(
            child: Text(
              title ?? "",
              style: Styles.appTitle(context: context),
            ),
          ),
          // Smart logo
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
      actions: actions ?? [],
    );
  }
}
