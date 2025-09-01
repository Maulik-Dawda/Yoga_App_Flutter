import 'package:flutter/material.dart';
import 'package:yoga_app/Themes/app_colors.dart';

class DietHomeScreen extends StatelessWidget {
  const DietHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dietTheme,
      body: Center(
        child: Text("Diet"),
      ),
    );
  }
}
