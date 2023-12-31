import 'package:flutter/material.dart';

import '../../core/res/theme/theme_manager.dart';
import '../../core/routes/app_router.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.action,
  });
  final void Function()? action;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-8, 0),
      child: IconButton(
        onPressed: () {
          if (action == null) {
            AppRouter.router.pop();
          } else {
            action!.call();
          }
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: getColor().themeColorBlack,
        ),
      ),
    );
  }
}
