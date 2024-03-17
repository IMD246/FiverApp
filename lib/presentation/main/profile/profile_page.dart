import '../../../core/extensions/ext_localization.dart';
import '../../../core/res/images.dart';
import '../../../core/utils/package_info_util.dart';
import 'components/setting_list.dart';
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
          SettingList(model: model),
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
            SizedBox(
              width: 64.w,
              height: 64.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(64.r),
                child: model.user?.avatar != null
                    ? Image.network(
                        model.user?.avatar ?? "",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        DImages.defaultAvatar,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -6,
              child: IconButton(
                onPressed: model.onUpdateAvatar,
                icon: Icon(
                  Icons.edit,
                  size: 20.w,
                  color: Colors.yellow,
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
              model.user?.fullName ?? "",
              style: text18.medium.copyWith(
                color: getColor().themeColor222222White,
              ),
            ),
            Text(
              model.user?.email ?? "",
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
