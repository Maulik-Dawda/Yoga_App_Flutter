import 'package:flutter/material.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/View/diet_home_screen.dart';
import 'package:yoga_app/View/meditation_home_screen.dart';
import 'package:yoga_app/View/profile_home_screen.dart';
import 'package:yoga_app/View/yoga_home_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    YogaHomeScreen(),
    MeditationHomeScreen(),
    DietHomeScreen(),
    ProfileHomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.yogaTheme,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: "Yoga"),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: "Meditation"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Diet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
