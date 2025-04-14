import 'package:flutter/material.dart';
import 'package:ngantor/pages/auth_pages/login_page.dart';
import 'package:ngantor/pages/auth_pages/register/register_page.dart';
import 'package:ngantor/services/providers/absen_provider.dart';
import 'package:ngantor/services/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AbsenProvider(),),
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
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
      initialRoute: "/login",
      routes: {
        "/login" : (context) => LoginPage(),
        "/register" : (context) => RegisterPage(),
      },
    );
  }
}

