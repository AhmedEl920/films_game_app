import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/constant/app_theme.dart';
import 'package:game_app/core/router/app_routes.dart';
import 'package:game_app/core/router/route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(393.72727272727275, 800.7272727272727),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      enableScaleText: () => true,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'افلام من غير كلام',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: const Locale('ar'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('ar')],
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splashRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
