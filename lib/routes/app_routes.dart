import 'package:flutter/material.dart';
import 'package:customers_payments/views/screens/complaint_list.dart';
import 'package:customers_payments/views/screens/home_screen.dart';
import 'package:customers_payments/views/screens/login.dart';
import 'package:customers_payments/views/screens/splash.dart';

class AppRoutes {
 // static const String splashScreen = '/';

  static const String loginScreen = '/login';

  static const String dashboardScreen = '/home_screen';

  static const String complaintListScreen = '/complaint_list';

 static Map<String, WidgetBuilder> routes = {
   // splashScreen: (context) => const Splash(),
    loginScreen: (context) => const Login(),
    dashboardScreen: (context) => const HomeScreen(),
    complaintListScreen: (context) => const ComplaintList(),
    //appNavigationScreen: (context) => AppNavigationScreen()
  };
}
