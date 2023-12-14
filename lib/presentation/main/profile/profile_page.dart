import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text("Profile page"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
