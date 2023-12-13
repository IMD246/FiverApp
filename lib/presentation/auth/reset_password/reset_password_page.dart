import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_state.dart';
import '../../../core/extensions/ext_localization.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/back_button.dart';
import '../../widgets/default_button.dart';
import 'components/reset_password_form.dart';
import 'reset_password_model.dart';

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
    model.init(widget.token);
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
                  action: model.onMoveToLogin,
                ),
                SizedBox(height: 30.w),
                Text(
                  context.loc.reset_password,
                  style: text34.bold.copyWith(
                    color: getColor().themeColorBlack,
                  ),
                ),
                SizedBox(height: 72.w),
                ResetPasswordForm(model: model),
                SizedBox(
                  height: 16.w,
                ),
                SizedBox(
                  height: 28.w,
                ),
                _resetPasswordButton(model, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resetPasswordButton(ResetPasswordModel model, BuildContext context) {
    return DefaultButton(
      title: context.loc.reset_password.toUpperCase(),
      onTap: model.onResetPassword,
    );
  }
}
