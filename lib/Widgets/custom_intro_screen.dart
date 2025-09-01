import 'package:flutter/material.dart';

class CustomIntroScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const CustomIntroScreen({super.key, required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: screenHeight * 0.3,
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A5ACD),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
