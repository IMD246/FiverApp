import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../di/locator_service.dart';
import '../res/theme/theme_manager.dart';
import '../routes/app_router.dart';
import '../utils/navigation_service.dart';
import 'app_model.dart';

class FiverApp extends StatefulWidget {
  const FiverApp({super.key, required this.titleApp});
  final String titleApp;

  @override
  State<FiverApp> createState() => _FiverAppState();
}

class _FiverAppState extends State<FiverApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
                    routerConfig: AppRouter.router,
                    title: widget.titleApp,
                    scaffoldMessengerKey: NavigationService.scaffoldKey,
                    builder: EasyLoading.init(),
                    theme: theme.themeData,
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
