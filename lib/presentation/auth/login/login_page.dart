import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/base/base_state.dart';
import '../../../core/enum.dart';
import '../../../core/extensions/ext_localization.dart';
import '../../../core/res/icons.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/default_button.dart';
import '../../widgets/social_button.dart';
import 'components/components.dart';
import 'login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginModel, LoginPage> {
  @override
  void initState() {
    super.initState();
    model.init();
  }

  @override
  Widget buildContentView(BuildContext context, LoginModel model) {
    return WillPopScope(
      onWillPop: model.onBack,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.w),
              Text(
                context.loc.login,
                style: text34.bold.copyWith(
                  color: getColor().themeColorBlack,
                ),
              ),
              SizedBox(height: 72.w),
              LoginForm(model: model),
              SizedBox(
                height: 16.w,
              ),
              _toForgotPasswordButton(model),
              SizedBox(
                height: 28.w,
              ),
              _loginButton(model, context),
              _toRegisterButton(model, context),
              SizedBox(height: 24.w),
              _socialButtons(context, model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toRegisterButton(LoginModel model, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: model.onMoveToRegister,
          child: Text(
            context.loc.sign_up,
            style: text14.medium.copyWith(
              color: getColor().themeColorGreen,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
        SvgPicture.asset(DIcons.arrowRight)
      ],
    );
  }

  Widget _socialButtons(BuildContext context, LoginModel model) {
    return Center(
      child: Column(
        children: [
          Text(
            context.loc.or_login_with_social_account,
            style: text14.medium.copyWith(
              color: getColor().textColorBlackWhiteInput,
            ),
          ),
          SizedBox(
            height: 12.w,
          ),
          SocialButton(
            socialIconType: SocialIconType.google,
            action: model.onLoginWithGoogle,
          ),
        ],
      ),
    );
  }

  Widget _toForgotPasswordButton(LoginModel model) {
    return GestureDetector(
      onTap: model.onMoveToForgotPassword,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            context.loc.forgot_your_password,
            style: text14.medium.copyWith(color: getColor().themeColorBlack),
          ),
          SizedBox(
            width: 3.w,
          ),
          SvgPicture.asset(DIcons.arrowRight)
        ],
      ),
    );
  }

  Widget _loginButton(LoginModel model, BuildContext context) {
    return DefaultButton(
      title: context.loc.login.toUpperCase(),
      onTap: model.onLogin,
    );
  }
}
