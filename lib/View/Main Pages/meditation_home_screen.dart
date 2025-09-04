import 'package:flutter/material.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/Widgets/custom_large_card_center_title.dart';
import 'package:yoga_app/Widgets/custom_medium_card_center_title.dart';
import 'package:yoga_app/Widgets/custom_section_title.dart';
import 'package:yoga_app/Widgets/custom_small_card_center_title.dart';
import 'package:yoga_app/Widgets/custom_vertical_tabs.dart';

class MeditationHomeScreen extends StatelessWidget {
  const MeditationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.meditationTheme,
        title: const Text("Meditation",style: TextStyle(color: Colors.white),),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.meditationTheme,
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: "Search",
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.005),
                  SizedBox(
                    height: screenHeight * 0.27,
                    child: CustomVerticalTabs(themeColor: AppColors.meditationTheme, vtab1: 'Sleep', vtab2: 'Relax', vtab3: 'Focus', category: 'men')
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  CustomSectionTitle(title: "Recommended For You"),
                  SizedBox(
                    height: screenHeight * 0.12,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        CustomSmallCardCenterTitle(image: "https://i.pinimg.com/736x/7f/d8/61/7fd86174f6b02b30b27560a212957249.jpg", title: "Mind Growth", onTap: () {  },),
                        CustomSmallCardCenterTitle(image: "https://i.pinimg.com/736x/7f/d8/61/7fd86174f6b02b30b27560a212957249.jpg", title: "Mind Growth", onTap: () {  },),
                        CustomSmallCardCenterTitle(image: "https://i.pinimg.com/736x/7f/d8/61/7fd86174f6b02b30b27560a212957249.jpg", title: "Mind Growth", onTap: () {  },),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  CustomSectionTitle(title: "Favourite"),
                  SizedBox(
                    height: screenHeight * 0.15,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        CustomMediumCardCenterTitle(image: "https://i.pinimg.com/736x/71/b1/89/71b189c16bcc54f17f0af121cfbe3c2a.jpg", title: "Get Motivated", onTap: () {  },),
                        CustomMediumCardCenterTitle(image: "https://i.pinimg.com/736x/71/b1/89/71b189c16bcc54f17f0af121cfbe3c2a.jpg", title: "Get Motivated", onTap: () {  },),
                        CustomMediumCardCenterTitle(image: "https://i.pinimg.com/736x/71/b1/89/71b189c16bcc54f17f0af121cfbe3c2a.jpg", title: "Get Motivated", onTap: () {  },),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  CustomSectionTitle(title: "New"),
                  SizedBox(
                    height: screenHeight * 0.20,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        CustomLargeCardCenterTitle(image: "https://i.pinimg.com/736x/71/b1/89/71b189c16bcc54f17f0af121cfbe3c2a.jpg", title: "Get Motivated", onTap: () {  },),
                        CustomLargeCardCenterTitle(image: "https://i.pinimg.com/736x/71/b1/89/71b189c16bcc54f17f0af121cfbe3c2a.jpg", title: "Get Motivated", onTap: () {  },),
                        CustomLargeCardCenterTitle(image: "https://i.pinimg.com/736x/71/b1/89/71b189c16bcc54f17f0af121cfbe3c2a.jpg", title: "Get Motivated", onTap: () {  },),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
