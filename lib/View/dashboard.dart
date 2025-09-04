import 'package:flutter/material.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/View/Main%20Pages/diet_home_screen.dart';
import 'package:yoga_app/View/Main%20Pages/meditation_home_screen.dart';
import 'package:yoga_app/View/Main%20Pages/profile_home_screen.dart';
import 'package:yoga_app/View/Main%20Pages/yoga_home_screen.dart';

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

  final List<Color> _navColors = [
    AppColors.yogaTheme,
    AppColors.meditationTheme,
    AppColors.dietTheme,
    AppColors.profileTheme
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: _navColors[_currentIndex],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavItem(Icons.spa, "Yoga", 0, AppColors.yogaTheme),
          _buildNavItem(Icons.self_improvement, "Meditation", 1, AppColors.meditationTheme),
          _buildNavItem(Icons.restaurant, "Diet", 2, AppColors.dietTheme),
          _buildNavItem(Icons.person, "Profile", 3, AppColors.profileTheme),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index, Color themeColor) {
    bool isActive = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: isActive
          ? Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: themeColor, size: 26),
      )
          : Icon(icon, color: Colors.white70, size: 26),
      label: label,
    );
  }
}
