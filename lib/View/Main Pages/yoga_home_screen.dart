import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/Controller/popular_yoga_list_controller.dart';
import 'package:yoga_app/Controller/recommended_yoga_controller.dart';
import 'package:yoga_app/Controller/weight_loss_yoga_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/View/Auth%20Pages/login.dart';
import 'package:yoga_app/View/Detail%20Pages/popular_yoga_list.dart';
import 'package:yoga_app/View/Detail%20Pages/weight_loss_yoga_list.dart';
import 'package:yoga_app/View/Detail%20Pages/yoga_detail_screen.dart';
import 'package:yoga_app/Widgets/custom_large_card_bottom_title.dart';
import 'package:yoga_app/Widgets/custom_medium_card_bottom_title.dart';
import 'package:yoga_app/Widgets/custom_section_title.dart';
import 'package:yoga_app/Widgets/custom_small_card_bottom_title.dart';
import 'package:yoga_app/Widgets/custom_yoga_vertical_tabs.dart';

class YogaHomeScreen extends StatelessWidget {
  YogaHomeScreen({super.key});
  final RecommendedYogaController recommendedYogaControllerList = Get.put(RecommendedYogaController());
  final PopularYogaListController popularYogaListControllerList = Get.put(PopularYogaListController());
  final WeightLossYogaController weightLossYogaControllerList = Get.put(WeightLossYogaController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.yogaTheme,
        title: const Text("Yoga", style: TextStyle(color: Colors.white)),
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
            color: AppColors.yogaTheme,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.005),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          indicatorColor: AppColors.yogaTheme,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [Tab(text: "WOMEN"), Tab(text: "MEN")],
                        ),
                        SizedBox(
                          height: screenHeight * 0.27,
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                child: CustomYogaVerticalTabs(
                                  themeColor: AppColors.yogaTheme,
                                  vtab1: 'New',
                                  vtab2: 'Skilled',
                                  vtab3: 'Pro',
                                  category: 'women',
                                ),
                              ),
                              SizedBox(
                                child: CustomYogaVerticalTabs(
                                  themeColor: AppColors.yogaTheme,
                                  vtab1: 'New',
                                  vtab2: 'Skilled',
                                  vtab3: 'Pro',
                                  category: 'men',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "Popular Yoga Exercise"),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const PopularYogaList());
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(color: AppColors.yogaTheme),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.12,
                    child: Obx(() {
                      if (popularYogaListControllerList.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (popularYogaListControllerList.popularYogaList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: popularYogaListControllerList.popularYogaList.length,
                        itemBuilder: (context, index) {
                          final item = popularYogaListControllerList.popularYogaList[index];
                          return CustomSmallCardBottomTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            subTitle: item.category ?? "",
                            onTap: () {
                              Get.to(() => YogaDetailScreen(title: item.title ?? "", id: item.id ?? ""));
                            },
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "Recommended For You"),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.15,
                    child: Obx(() {
                      if (recommendedYogaControllerList.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (recommendedYogaControllerList.recommendedYogaList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: recommendedYogaControllerList.recommendedYogaList.length,
                        itemBuilder: (context, index) {
                          final item = recommendedYogaControllerList.recommendedYogaList[index];
                          return CustomMediumCardBottomTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            subTitle: item.category ?? "",
                            onTap: () {
                              Get.to(() => YogaDetailScreen(title: item.title ?? "", id: item.id ?? ""));
                            },
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "Yoga For Weight Loss"),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const WeightLossYogaList());
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(color: AppColors.yogaTheme),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.20,
                    child: Obx(() {
                      if (weightLossYogaControllerList.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (weightLossYogaControllerList.weightLossYogaList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: weightLossYogaControllerList.weightLossYogaList.length,
                        itemBuilder: (context, index) {
                          final item = weightLossYogaControllerList.weightLossYogaList[index];
                          return CustomLargeCardBottomTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            subTitle: item.category ?? "",
                            onTap: () {
                              Get.to(() => YogaDetailScreen(title: item.title ?? "", id: item.id ?? ""));
                            },
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
