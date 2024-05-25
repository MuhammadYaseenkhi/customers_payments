import 'package:customers_payments/routes/app_routes.dart';
import 'package:customers_payments/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_colors.dart';
import 'components/custom_animation.dart';
import 'localization/app_localization.dart';


GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  // Ensuring Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Running the app
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primaryColor
    ..backgroundColor = AppColors.secondaryColor
    ..indicatorColor = AppColors.primaryColor
    ..textColor = AppColors.primaryColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      builder: EasyLoading.init(),
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.red,
        colorScheme:ColorScheme.light(
            primary: appTheme.red900,
            background: AppColors.secondaryColor
        ),
        // useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(
          'en',
          '',
        ),
      ],
      initialRoute:AppRoutes.loginScreen, //AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
