import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/ext_localization.dart';
import '../../../widgets/input/text_input_default.dart';
import '../../../widgets/input/text_input_password.dart';
import '../login_model.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.model,
  });
  final LoginModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextInputDefault(
          controller: model.emailCtr,
          keyboardType: TextInputType.emailAddress,
          label: context.loc.email,
          textInputAction: TextInputAction.next,
          validator: model.emailValidatorCtr,
        ),
        SizedBox(height: 8.w),
        TextInputPassword(
          controller: model.passwordCtr,
          textInputAction: TextInputAction.done,
          validator: model.passwordValidatorCtr,
          label: context.loc.password,
        ),
      ],
    );
  }
}
