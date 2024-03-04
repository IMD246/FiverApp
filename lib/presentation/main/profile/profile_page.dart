import 'dart:io';

import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/images.dart';
import 'package:fiver/core/utils/package_info_util.dart';
import 'package:fiver/presentation/main/profile/components/setting_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_state.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import 'profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfileModel, ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, ProfileModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.w),
          Text(
            context.loc.my_profile,
            style: text34.bold.copyWith(
              color: getColor().themeColorBlack,
            ),
          ),
          SizedBox(height: 24.w),
          _profile(model),
          SizedBox(height: 28.w),
          const SettingList(),
          _versionWidget(),
        ],
      ),
    );
  }

  Widget _versionWidget() {
    return FutureBuilder(
      future: getVersion(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return Center(
          child: Text(
            snapshot.data ?? "",
            style: text16.copyWith(
              color: getColor().themeColor222222White,
            ),
          ),
        );
      },
    );
  }

  Widget _profile(ProfileModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ValueListenableBuilder(
              valueListenable: model.avatar,
              builder: (context, avatar, child) {
                return CircleAvatar(
                  radius: 50.r,
                  backgroundImage:
                      avatar == null ? AssetImage(DImages.defaultAvatar) : null,
                  child: avatar != null ? Image.file(File(avatar.path)) : null,
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: model.onUpdateAvatar,
                icon: Icon(
                  Icons.edit,
                  size: 24.w,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 18.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Matilda Brown",
              style: text18.medium.copyWith(
                color: getColor().themeColor222222White,
              ),
            ),
            Text(
              "matildabrown@mail.com",
              style: text14.copyWith(
                color: getColor().themeColorGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
