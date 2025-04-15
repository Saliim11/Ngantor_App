import 'package:flutter/material.dart';
import 'package:ngantor/pages/auth_pages/login/login_page.dart';
import 'package:ngantor/pages/auth_pages/register/register_page.dart';
import 'package:ngantor/pages/splash_page/splash_screen.dart';
import 'package:ngantor/pages/user_pages/main_screen/main_screen.dart';
import 'package:ngantor/services/providers/attendance_provider.dart';
import 'package:ngantor/services/providers/widget_provider.dart';
import 'package:ngantor/services/providers/auth_provider.dart';
import 'package:ngantor/services/providers/maps_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetProvider(),),
        ChangeNotifierProvider(create: (context) => MapsProvider(),),
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
        ChangeNotifierProvider(create: (context) => AttendanceProvider(),),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => SplashScreen(),
        "/login" : (context) => LoginPage(),
        "/register" : (context) => RegisterPage(),
        "/main" : (context) => MainScreen(),
      },
    );
  }
}

