import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';

class SettingList extends StatelessWidget {
  const SettingList({super.key});

  @override
  Widget build(BuildContext context) {
    List<_SettingItemUI> settings = [
      _SettingItemUI(
        title: context.loc.my_orders,
        subtitle: context.loc.subtitle_orders(12),
        ontap: () {},
      ),
      _SettingItemUI(
        title: context.loc.shipping_adresses,
        subtitle: context.loc.subtitle_shipping_addresses(3),
        ontap: () {},
      ),
      _SettingItemUI(
        title: context.loc.payment_methods,
        subtitle: "Visa **34",
        ontap: () {},
      ),
      _SettingItemUI(
        title: context.loc.promocodes,
        subtitle: context.loc.subtitle_promocodes,
        ontap: () {},
      ),
      _SettingItemUI(
        title: context.loc.my_reviews,
        subtitle: context.loc.subtitle_my_reviews(4),
        ontap: () {},
      ),
      _SettingItemUI(
        title: context.loc.settings,
        subtitle: context.loc.subtitle_settings,
        ontap: () {},
      ),
    ];
    return Expanded(
      child: ListView(
        children: settings
            .map(
              (e) => _settingItem(e),
            )
            .toList(),
      ),
    );
  }

  Widget _settingItem(_SettingItemUI e) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.w,
        horizontal: 12.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.title,
            style: text16.medium.copyWith(
              color: getColor().themeColor222222White,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              InkWell(
                onTap: e.ontap,
                child: Icon(
                  Icons.arrow_forward_ios,
                  fill: 1,
                  color: getColor().themeColorGrey,
                ),
              ),
            ],
          ),
          Text(
            e.subtitle,
            style: text11.copyWith(
              color: getColor().themeColorGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingItemUI {
  final String title;
  final String subtitle;
  final VoidCallback ontap;

  _SettingItemUI({
    required this.title,
    required this.subtitle,
    required this.ontap,
  });
}
