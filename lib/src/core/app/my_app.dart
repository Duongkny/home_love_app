
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homelove/l10n/output/app_localization.dart';
import 'package:homelove/src/constant/app_theme.dart';
import 'package:homelove/src/core/app/provider.dart';


import '../../router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(
      ThemeData.light().textTheme,
    );

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: appProviders,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'HomeLove',

            // Theme
            theme: appTheme.light(),
            darkTheme: appTheme.dark(),
            themeMode: ThemeMode.system,

            // Localization
            localizationsDelegates:
                AppLocalizations.localizationsDelegates,
            supportedLocales:
                AppLocalizations.supportedLocales,

            // GoRouter
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
