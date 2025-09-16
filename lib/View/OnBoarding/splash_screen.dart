import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/View/Auth%20Pages/login.dart';
import 'package:yoga_app/View/OnBoarding/intro_page.dart';
import 'package:yoga_app/View/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedIn) {
      Get.offAll(() => const Dashboard());
    } else {
        Get.offAll(() => const IntroPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: screenHeight * 0.31,
          width: screenWidth * 0.7,
          child: const Image(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
