import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/base/base_state.dart';
import '../../core/extensions/ext_localization.dart';
import '../../core/res/colors.dart';
import '../../core/res/icons.dart';
import 'bag/bag_page.dart';
import 'favorites/favorites_page.dart';
import 'home/home_page.dart';
import 'main_model.dart';
import 'profile/profile_page.dart';
import 'shop/shop_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainModel, MainPage> {
  List<Widget> pages = const [
    ProfilePage(),
    HomePage(),
    ShopPage(),
    BagPage(),
    FavoritesPage(),
  ];
  @override
  void initState() {
    super.initState();
    model.init(widget.tabIndex);
  }

  @override
  Widget buildContentView(BuildContext context, MainModel model) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        model.doubleTapToExistApp();
      },
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: model.pageController,
        children: pages,
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
              iconAct: DIcons.homeAct,
            ),
            _bottomNavigationBarItem(
              label: context.loc.shop,
              icon: DIcons.shop,
              iconAct: DIcons.shopAct,
            ),
            _bottomNavigationBarItem(
              label: context.loc.bag,
              icon: DIcons.shoppingBag,
              iconAct: DIcons.shoppingBagAct,
            ),
            _bottomNavigationBarItem(
              label: context.loc.favorites,
              icon: DIcons.heart,
              iconAct: DIcons.heartAct,
            ),
            _bottomNavigationBarItem(
              label: context.loc.profile,
              icon: DIcons.profile,
              iconAct: DIcons.profileAct,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required String label,
    required String icon,
    required String iconAct,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        icon,
        width: 30.w,
        height: 30.w,
        fit: BoxFit.scaleDown,
      ),
      activeIcon: SvgPicture.asset(
        iconAct,
        width: 30.w,
        height: 30.w,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  @override
  Widget? get bottomNavigationBar => _bottomNavigation(model);
}
