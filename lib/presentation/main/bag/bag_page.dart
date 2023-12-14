import '../../../core/base/base_state.dart';
import 'bag_model.dart';
import 'package:flutter/material.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});
  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends BaseState<BagModel, BagPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, BagModel model) {
    return const Center(
      child: Text("Bag page"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
