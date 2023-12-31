import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/ext_localization.dart';
import '../../../widgets/input/text_input_password.dart';
import '../reset_password_model.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.model,
  });
  final ResetPasswordModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextInputPassword(
          controller: model.newPasswordCtr,
          validator: model.newPasswordValidatorCtr,
          textInputAction: TextInputAction.next,
          label: context.loc.new_password,
        ),
        SizedBox(height: 8.w),
        TextInputPassword(
          controller: model.confirmPasswordCtr,
          label: context.loc.confirm_password,
          textInputAction: TextInputAction.done,
          validator: model.confirmPasswordValidatorCtr,
        ),
      ],
    );
  }
}
