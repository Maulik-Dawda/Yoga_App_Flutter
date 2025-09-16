import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoga_app/View/Auth%20Pages/login.dart';
import 'package:yoga_app/View/dashboard.dart';
import 'package:yoga_app/View/OnBoarding/intro_page.dart';
import 'View/OnBoarding/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yoga App',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),

      getPages: [
        GetPage(name: "/splash", page: () => const SplashScreen()),
        GetPage(name: "/intro", page: () => const IntroPage()),
        GetPage(name: "/login", page: () => const Login()),
        GetPage(name: "/dashboard", page: () => const Dashboard()),
      ],
    );
  }
}
