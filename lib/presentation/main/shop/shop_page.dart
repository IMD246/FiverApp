import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/presentation/main/bag/bag_model.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends BaseState<BagModel, ShopPage>
    with AutomaticKeepAliveClientMixin {
      
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, BagModel model) {
    return const Scaffold(
      body: Center(
        child: Text("Shop page"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
