import 'package:flutter/material.dart';
import 'package:yoga_app/Widgets/custom_meditation_list_tab.dart';

class CustomMeditationVerticalTabs extends StatelessWidget {
  final Color themeColor;
  final String vtab1;
  final String vtab2;
  final String vtab3;

  const CustomMeditationVerticalTabs({
    super.key,
    required this.themeColor,
    required this.vtab1,
    required this.vtab2,
    required this.vtab3,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: SizedBox(
              height: screenHeight * 0.05,
              width: screenWidth * 0.8,
              child: TabBar(
                dividerHeight: 0,
                labelColor: themeColor,
                unselectedLabelColor: Colors.black,
                indicatorColor: themeColor,
                tabs: [
                  Tab(text: vtab1),
                  Tab(text: vtab2),
                  Tab(text: vtab3),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 250,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CustomMeditationListTab(subCategory: vtab1.toLowerCase()),
                  CustomMeditationListTab(subCategory: vtab2.toLowerCase()),
                  CustomMeditationListTab(subCategory: vtab3.toLowerCase()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
