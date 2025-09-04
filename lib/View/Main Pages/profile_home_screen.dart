import 'package:flutter/material.dart';
import 'package:yoga_app/Themes/app_colors.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileTheme,
      body: Center(
        child: Text("Profile"),
      ),
    );
  }
}
