import 'package:fiver/domain/provider/app_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../routes/app_router.dart';
import '../utils/navigation_service.dart';

class FiverApp extends StatelessWidget {
  const FiverApp({super.key, required this.titleApp});
  final String titleApp;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: locator<AppModel>()),
              ChangeNotifierProvider.value(value: locator<ThemeManager>()),
            ],
            builder: (context, child) {
              return Consumer<ThemeManager>(
                builder: (context, theme, child) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    title: titleApp,
                    scaffoldMessengerKey: NavigationService.scaffoldKey,
                    builder: EasyLoading.init(),
                    theme: theme.themeData,
                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
