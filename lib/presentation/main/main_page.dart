import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:fiver/presentation/main/main_model.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainModel, MainPage> {
  @override
  Widget buildContentView(BuildContext context, MainModel model) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () async {
              await locator<UserRepository>().logout();
            },
            child: const Text("Main Page")),
      ),
    );
  }
}
