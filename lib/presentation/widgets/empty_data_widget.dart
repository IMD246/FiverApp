import 'package:flutter/material.dart';

import '../../core/extensions/ext_localization.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? message;

  const EmptyDataWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.25),
      child: Text(
        message ?? context.loc.no_data,
        style: text14.medium.copyWith(color: getColor().themeColorBlackWhite),
      ),
    );
  }
}
