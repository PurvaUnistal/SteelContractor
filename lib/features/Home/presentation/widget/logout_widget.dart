import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:steel_contractor/Utils/common_widgets/button_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_styles.dart';
import 'package:steel_contractor/features/Login/presentation/login_page.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                AppString.logout + "?",
                style: Styles.stars,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                AppString.logoutMsg,
                style: Styles.title,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ButtonWidget(
                        text: AppString.logout,
                        onPressed: () async {
                          await SharedPref.clearAll();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                                  (route) => false);
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Flexible(
                    flex: 2,
                    child: ButtonWidget(
                        text: AppString.no,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
