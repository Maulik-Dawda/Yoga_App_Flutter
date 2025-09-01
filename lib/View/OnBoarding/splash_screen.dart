import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/View/OnBoarding/intro_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Timer(Duration(seconds: 3), () {
      Get.to(() => IntroPage());
    });

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: screenHeight * 0.31,
          width: screenWidth * 0.7,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
