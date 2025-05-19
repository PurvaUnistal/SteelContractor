import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/button_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/features/Login/presentation/login_page.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.4,
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Text(
            AppString.logout + "?",
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            AppString.logoutMsg,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ButtonWidget(
              text: AppString.logout,
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                    (route) => false);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ButtonWidget(
              text: AppString.cancel,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
