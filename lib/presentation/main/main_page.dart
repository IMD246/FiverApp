import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/icons.dart';
import 'package:fiver/presentation/main/bag/bag_page.dart';
import 'package:fiver/presentation/main/favorites/favorites_page.dart';
import 'package:fiver/presentation/main/home/home_page.dart';
import 'package:fiver/presentation/main/main_model.dart';
import 'package:fiver/presentation/main/profile/profile_page.dart';
import 'package:fiver/presentation/main/shop/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/res/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainModel, MainPage> {
  List<Widget> pages = const [
    ShopPage(),
    HomePage(),
    BagPage(),
    FavoritesPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
    model.init(widget.tabIndex);
  }

  @override
  Widget buildContentView(BuildContext context, MainModel model) {
    return WillPopScope(
      onWillPop: model.doubleTapToExistApp,
      child: Scaffold(
        bottomNavigationBar: _bottomNavigation(model),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: model.pageController,
          children: pages,
        ),
      ),
    );
  }

  ValueListenableBuilder<int> _bottomNavigation(MainModel model) {
    return ValueListenableBuilder(
      valueListenable: model.tabValue,
      builder: (context, tabIndex, child) {
        return BottomNavigationBar(
          fixedColor: colorEF3651,
          unselectedItemColor: color9B9B9B,
          type: BottomNavigationBarType.fixed,
          currentIndex: tabIndex,
          onTap: model.onTabChanged,
          items: [
            _bottomNavigationBarItem(
              label: context.loc.home,
              icon: DIcons.home,
            ),
            _bottomNavigationBarItem(
              label: context.loc.shop,
              icon: DIcons.shop,
            ),
            _bottomNavigationBarItem(
              label: context.loc.bag,
              icon: DIcons.shoppingBag,
            ),
            _bottomNavigationBarItem(
              label: context.loc.favorites,
              icon: DIcons.heart,
            ),
            _bottomNavigationBarItem(
              label: context.loc.profile,
              icon: DIcons.profile,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required String label,
    required String icon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        icon,
        width: 30.w,
        height: 30.w,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          color9B9B9B,
          BlendMode.srcIn,
        ),
      ),
      activeIcon: SvgPicture.asset(
        icon,
        width: 30.w,
        height: 30.w,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          colorEF3651,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
