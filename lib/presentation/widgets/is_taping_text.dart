import 'package:flutter/material.dart';

import '../../core/extensions/ext_localization.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';

class IsTapingText extends StatelessWidget {
  const IsTapingText({super.key, required this.isTaping});
  final ValueNotifier<bool> isTaping;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isTaping,
      builder: (context, isTaping, child) {
        return Center(
          key: ValueKey(isTaping),
          child: Text(
            isTaping
                ? context.loc.searching
                : context.loc.there_is_no_data_matched,
            style: text20.bold.copyWith(
              color: getColor().themeColorBlackWhite,
            ),
          ),
        );
      },
    );
  }
}
