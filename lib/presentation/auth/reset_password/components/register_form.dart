// import 'package:fiver/core/extensions/ext_localization.dart';
// import 'package:fiver/presentation/widgets/input/text_input_password.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../widgets/input/text_input_default.dart';
// import '../reset_password_model.dart';

// class RegisterForm extends StatelessWidget {
//   const RegisterForm({
//     super.key,
//     required this.model,
//   });
//   final RegisterModel model;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TextInputDefault(
//           controller: model.nameCtr,
//           validator: model.nameValidatorCtr,
//           textInputAction: TextInputAction.next,
//           label: context.loc.name,
//         ),
//         SizedBox(height: 8.w),
//         TextInputDefault(
//           controller: model.emailCtr,
//           keyboardType: TextInputType.emailAddress,
//           label: context.loc.email,
//           textInputAction: TextInputAction.next,
//           validator: model.emailValidatorCtr,
//         ),
//         SizedBox(height: 8.w),
//         TextInputPassword(
//           controller: model.passwordCtr,
//           textInputAction: TextInputAction.done,
//           validator: model.passwordValidatorCtr,
//           label: context.loc.password,
//         ),
//       ],
//     );
//   }
// }
