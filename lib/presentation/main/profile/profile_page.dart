import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_state.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text("Profile page"),
        ),
        SizedBox(height: 20.w),
        InkWell(
          onTap: model.onLogout,
          child: Text("Logout", style: text30),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
