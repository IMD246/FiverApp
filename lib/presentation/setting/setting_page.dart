import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/helper/bottom_sheet_helper.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:fiver/core/routes/app_router.dart';
import 'package:fiver/core/utils/collection_util.dart';
import 'package:fiver/presentation/setting/setting_model.dart';
import 'package:fiver/presentation/widgets/common_appbar.dart';
import 'package:fiver/presentation/widgets/default_button.dart';
import 'package:fiver/presentation/widgets/input/text_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends BaseState<SettingModel, SettingPage> {
  @override
  void initState() {
    super.initState();
    model.init();
  }

  @override
  Widget buildContentView(BuildContext context, SettingModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.w),
            Text(
              context.loc.setting,
              style: text34.bold.copyWith(
                color: getColor().themeColorBlack,
              ),
            ),
            SizedBox(height: 23.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.loc.personal_infomation,
                  style: text16.medium.copyWith(
                    color: getColor().themeColorBlack,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    context.loc.change,
                    style: text16.medium.copyWith(
                      color: getColor().themeColorGrey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 21.w),
            _containerInput(
              context.loc.full_name,
              model.user?.fullName,
            ),
            SizedBox(height: 24.w),
            _containerInput(
              context.loc.date_of_birth,
              "1/2/1999",
            ),
            SizedBox(height: 54.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.loc.password,
                  style: text16.medium.copyWith(
                    color: getColor().themeColorBlack,
                  ),
                ),
                InkWell(
                  onTap: () {
                    commonBottomSheet(
                      context: context,
                      widget: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.loc.password_change,
                                style: text18.medium.copyWith(
                                  color: getColor().themeColorBlack,
                                ),
                              ),
                              SizedBox(height: 18.w),
                              TextInputPassword(
                                controller: model.oldPasswordCtr,
                                label: context.loc.old_password,
                                validator: model.validatorOldPassword,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 14.w),
                              _toForgotPasswordButton(),
                              SizedBox(height: 18.w),
                              TextInputPassword(
                                controller: model.newPasswordCtr,
                                label: context.loc.new_password,
                                validator: model.validatorNewPassword,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 24.w),
                              TextInputPassword(
                                controller: model.repeatPasswordCtr,
                                label: context.loc.repeat_new_password,
                                validator: model.validatorRepeatPassword,
                              ),
                              SizedBox(height: 32.w),
                              DefaultButton(
                                title: context.loc.save_password,
                                onTap: model.onSavePassword,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    context.loc.change,
                    style: text16.medium.copyWith(
                      color: getColor().themeColorGrey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 21.w),
            _containerInput(
              context.loc.password,
              "********",
            ),
            SizedBox(height: 55.w),
            Text(
              context.loc.notifications,
              style: text16.medium.copyWith(
                color: getColor().themeColorBlack,
              ),
            ),
            SizedBox(height: 23.w),
            _switchItem(
              context,
              context.loc.sales,
              true,
              model.onChangeSalesNotification,
            ),
            SizedBox(height: 24.w),
            _switchItem(
              context,
              context.loc.new_arrivals,
              true,
              model.onChangeNewArrivalsNotification,
            ),
            SizedBox(height: 24.w),
            _switchItem(
              context,
              context.loc.delivery_status_changes,
              false,
              model.onChangeDeliveryStatusNotification,
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchItem(
    BuildContext context,
    String title,
    bool value,
    void Function(bool value)? onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: text14.medium.copyWith(
            color: getColor().themeColorBlack,
          ),
        ),
        Switch(
          value: value,
          activeColor: color2AA952,
          activeTrackColor: color9B9B9B.withOpacity(0.15),
          inactiveThumbColor: colorWhite,
          inactiveTrackColor: color9B9B9B.withOpacity(0.15),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  CommonAppbar? get appbar => const CommonAppbar(
        title: "",
      );

  Widget _toForgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        InkWell(
          onTap: () => AppRouter.router.push(AppRouter.forgotPasswordPath),
          child: Text(
            context.loc.forgot_your_password,
            style: text14.medium.copyWith(color: getColor().themeColorBlack),
          ),
        ),
      ],
    );
  }

  Widget _containerInput(
    String title,
    String? value,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 14.w,
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.r,
            blurStyle: BlurStyle.outer,
            offset: const Offset(0, 1),
            color: color000000.withOpacity(
              0.05,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: text14.copyWith(
              color: getColor().themeColorGrey,
            ),
          ),
          if (!value.isNullOrEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                value!,
                style: text14.copyWith(
                  color: getColor().themeColorBlack,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
