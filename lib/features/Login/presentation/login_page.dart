import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kenburns_nullsafety/kenburns_nullsafety.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:steel_contractor/Utils/common_widgets/button_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/icon_button.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_icon.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/common_style.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/Utils/common_widgets/text_form_widget.dart';
import 'package:steel_contractor/features/Login/domain/bloc/login_bloc.dart';
import 'package:steel_contractor/features/Login/domain/bloc/login_event.dart';
import 'package:steel_contractor/features/Login/domain/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context).add(LoginPageLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginFetchDataState) {
            return Center(child: _buildLayout(dataState: state));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildLayout({required LoginFetchDataState dataState}) {
    return Stack(
      children: [
        Positioned.fill(
          child: KenBurns(
            maxScale: 3,
            child: Image.asset(
              "assets/images/login_background.jpg",
              opacity: const AlwaysStoppedAnimation(0.5),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8.0,
            ),
            child: Card(
              elevation: 8.0,
              // shadowColor: AppColor.yellow800,
              color: Colors.white.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _logoWidget(),
                    CommonStyle.vertical(context: context),
                    Text(
                      AppIcon.domainName(),
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..shader = LinearGradient(
                                colors: <Color>[
                                  EnvironmentConfig.of(context)!.secondaryTheme,
                                  EnvironmentConfig.of(context)!.primaryTheme,
                                ],
                              ).createShader(
                                Rect.fromLTWH(
                                  0.0,
                                  0.0,
                                  300.0,
                                  0.0,
                                ), // Width controls gradient spread
                              ),
                      ),
                    ),

                    CommonStyle.vertical(context: context),
                    _emailWidget(dataState: dataState),
                    CommonStyle.vertical(context: context),
                    _passwordWidget(dataState: dataState),
                    CommonStyle.vertical(context: context),
                    _loginBtnWidget(dataState: dataState),
                    CommonStyle.vertical(context: context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildkLayout({required LoginFetchDataState dataState}) {
    var h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned.fill(
            child: KenBurns(
              maxScale: 3,
              child: Image.asset(
                opacity: const AlwaysStoppedAnimation(.5),
                "assets/images/login_background.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: h * 0.6,
                child: Card(
                  elevation: 8,
                  // shadowColor: AppColor.,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _emailWidget(dataState: dataState),
                        CommonStyle.vertical(context: context),
                        _passwordWidget(dataState: dataState),
                        CommonStyle.vertical(context: context),
                        CommonStyle.vertical(context: context),
                        _loginBtnWidget(dataState: dataState),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(top: -80, left: .0, right: .0, child: _logoWidget()),
        ],
      ),
    );
  }

  Widget _logoWidget() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Image.asset(
        AppIcon.logo(),
        width: w * 0.4,
        height: h * 0.16,
      ),
    );
  }

  Widget _emailWidget({required LoginFetchDataState dataState}) {
    return TextFieldWidget(
      label: AppString.emailLabel,
      hintText: AppString.emailLabel,
      autofillHints: [AutofillHints.email, AutofillHints.password],
      keyboardType: TextInputType.emailAddress,
      controller: dataState.emailController,
      prefixIcon: IconButtonWidget(iconData: Icons.email, onPressed: () {}),
    );
  }

  Widget _passwordWidget({required LoginFetchDataState dataState}) {
    return TextFieldWidget(
      label: AppString.passwordLabel,
      hintText: AppString.passwordLabel,
      autofillHints: const [AutofillHints.password, AutofillHints.email],
      keyboardType: TextInputType.visiblePassword,
      controller: dataState.passwordController,
      prefixIcon: IconButtonWidget(iconData: Icons.password, onPressed: () {}),
      suffixIcon: IconButtonWidget(
        iconData:
            dataState.isPassword ? Icons.visibility_off : Icons.visibility,
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(
            LoginHideShowPasswordEvent(
              isHideShow: dataState.isPassword == true ? false : true,
            ),
          );
        },
      ),
      obscureText: dataState.isPassword,
    );
  }

  Widget _loginBtnWidget({required LoginFetchDataState dataState}) {
    return dataState.isPageLoader == false
        ? ButtonWidget(
          text: AppString.login,
          onPressed: () {
            FocusScope.of(context).unfocus();
            TextInput.finishAutofillContext();
            BlocProvider.of<LoginBloc>(
              context,
            ).add(LoginSubmitDataEvent(context: context, isLoginLoading: true));
          },
        )
        : DottedLoaderWidget();
  }
}
