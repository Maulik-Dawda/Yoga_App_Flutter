import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/Controller/new_meditation_controller.dart';
import 'package:yoga_app/Controller/recommended_meditation_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/View/Auth%20Pages/login.dart';
import 'package:yoga_app/View/Detail%20Pages/meditation_detail_screen.dart';
import 'package:yoga_app/View/Detail%20Pages/new_meditation_list.dart';
import 'package:yoga_app/View/Detail%20Pages/recommended_meditation_list.dart';
import 'package:yoga_app/Widgets/custom_large_card_center_title.dart';
import 'package:yoga_app/Widgets/custom_meditation_vertical_tabs.dart';
import 'package:yoga_app/Widgets/custom_section_title.dart';
import 'package:yoga_app/Widgets/custom_small_card_center_title.dart';

class MeditationHomeScreen extends StatelessWidget {
  MeditationHomeScreen({super.key});

  final NewMeditationController newMeditationController = Get.put(NewMeditationController());
  final RecommendedMeditationController recommendedMeditationController = Get.put(RecommendedMeditationController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.meditationTheme,
        title: const Text("Meditation",style: TextStyle(color: Colors.white),),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              if (value == 'logout') {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool("isLoggedIn", false);
                Get.offAll(() => const Login());
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
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
                    child: CustomMeditationVerticalTabs(themeColor: AppColors.meditationTheme, vtab1: 'Sleep', vtab2: 'Relax', vtab3: 'Focus')
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "Recommended For You"),
                      TextButton(onPressed: (){
                        Get.to(() => const RecommendedMeditationList());
                      }, child: Text("See All",style: TextStyle(color: AppColors.meditationTheme),))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.12,
                    child: Obx(() {
                      if (recommendedMeditationController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (recommendedMeditationController.recommendedMeditationList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final item = recommendedMeditationController.recommendedMeditationList[index];
                          return CustomSmallCardCenterTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            onTap: () {Get.to(() => MeditationDetailScreen(title: item.title ?? "", id: item.id ?? ""));},
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "New"),
                      TextButton(onPressed: (){
                        Get.to(() => const NewMeditationList());
                      }, child: Text("See All",style: TextStyle(color: AppColors.meditationTheme),))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.20,
                    child: Obx(() {
                      if (newMeditationController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (newMeditationController.newMeditationList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final item = newMeditationController.newMeditationList[index];
                          return CustomLargeCardCenterTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            onTap: () {Get.to(() => MeditationDetailScreen(title: item.title ?? "", id: item.id ?? ""));},
                          );
                        },
                      );
                    }),
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
