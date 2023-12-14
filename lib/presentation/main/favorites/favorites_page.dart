import 'package:flutter/material.dart';

import '../../../core/base/base_state.dart';
import 'favorites_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends BaseState<FavoritesModel, FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, FavoritesModel model) {
    return const Center(
      child: Text("Favorites page"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
