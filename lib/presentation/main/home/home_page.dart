import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/presentation/main/home/home_model.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomeModel, HomePage>{

  @override
  Widget buildContentView(BuildContext context, HomeModel model) {
    return const Scaffold(
      body: Center(
        child: Text("Home page"),
      ),
    );
  }


}
