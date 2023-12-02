import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/icons.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/presentation/auth/register/register_model.dart';
import 'package:fiver/presentation/auth/reset_password/reset_password_model.dart';
import 'package:fiver/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/default_button.dart';
import '../../widgets/social_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.token});
  final String token;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends BaseState<ResetPasswordModel, ResetPasswordPage> {
  @override
  void initState() {
    super.initState();
    model.init(widget.token);
  }

  @override
  void didUpdateWidget(covariant ResetPasswordPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.token != widget.token) {
      model.init(widget.token);
    }
  }

  @override
  Widget buildContentView(BuildContext context, ResetPasswordModel model) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.w,
                ),
                BackButtonWidget(
                  action: () {
                    model.onMoveToLogin();
                  },
                ),
                SizedBox(height: 30.w),
                Text(
                  context.loc.change_password,
                  style: text34.bold.copyWith(
                    color: getColor().themeColorBlack,
                  ),
                ),
                SizedBox(height: 72.w),
                // RegisterForm(model: model),
                SizedBox(
                  height: 16.w,
                ),
                // _toLoginButton(model),
                // SizedBox(
                //   height: 28.w,
                // ),
                // _signUpButton(model, context),
                // SizedBox(height: 24.w),
                // _socialButtons(context, model),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButtons(BuildContext context, RegisterModel model) {
    return Center(
      child: Column(
        children: [
          Text(
            context.loc.or_sign_up_with_social_account,
            style: text14.medium.copyWith(
              color: getColor().textColorBlackWhiteInput,
            ),
          ),
          SizedBox(
            height: 12.w,
          ),
          SocialButton(
            socialIconType: SocialIconType.google,
            action: () async {
              await model.onRegisterWithGoogle();
            },
          ),
        ],
      ),
    );
  }

  Widget _toLoginButton(RegisterModel model) {
    return GestureDetector(
      onTap: model.onMoveToLogin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            context.loc.already_have_an_account,
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

  Widget _signUpButton(RegisterModel model, BuildContext context) {
    return DefaultButton(
      title: context.loc.sign_up.toUpperCase(),
      onTap: () async {
        await model.onRegister();
      },
    );
  }
}
