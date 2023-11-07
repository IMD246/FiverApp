import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/back_button.dart';
import '../../widgets/default_button.dart';
import '../../widgets/input/text_input_default.dart';
import 'forgot_password_model.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends BaseState<ForgotPasswordModel, ForgotPasswordPage> {
  @override
  Widget buildContentView(BuildContext context, ForgotPasswordModel model) {
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
                    model.onBack();
                  },
                ),
                SizedBox(height: 30.w),
                Text(
                  context.loc.forgot_password,
                  style: text34.bold.copyWith(
                    color: getColor().themeColorBlack,
                  ),
                ),
                SizedBox(height: 72.w),
                Text(
                  context.loc.notice_forgot_password,
                  style: text14.medium.copyWith(
                    color: getColor().themeColorBlackWhite,
                  ),
                ),
                SizedBox(height: 16.w),
                TextInputDefault(
                  controller: model.emailCtr,
                  keyboardType: TextInputType.emailAddress,
                  label: context.loc.email,
                  textInputAction: TextInputAction.next,
                  validator: model.emailValidateCtr,
                ),
                SizedBox(
                  height: 28.w,
                ),
                _sendButton(model, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sendButton(
    ForgotPasswordModel model,
    BuildContext context,
  ) {
    return DefaultButton(
      title: context.loc.send.toUpperCase(),
      onTap: () async {
        await model.onSend();
      },
    );
  }
}
