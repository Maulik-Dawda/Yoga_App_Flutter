import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/Controller/popular_diet_controller.dart';
import 'package:yoga_app/Controller/recommended_diet_controller.dart';
import 'package:yoga_app/Controller/you_must_try_diet_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/View/Auth%20Pages/login.dart';
import 'package:yoga_app/View/Detail%20Pages/diet_detail_screen.dart';
import 'package:yoga_app/View/Detail%20Pages/popular_diet_list.dart';
import 'package:yoga_app/View/Detail%20Pages/recommended_diet_list.dart';
import 'package:yoga_app/View/Detail%20Pages/you_must_try_diet_list.dart';
import 'package:yoga_app/Widgets/custom_diet_vertical_tabs.dart';
import 'package:yoga_app/Widgets/custom_large_card_bottom_title.dart';
import 'package:yoga_app/Widgets/custom_medium_card_bottom_title.dart';
import 'package:yoga_app/Widgets/custom_section_title.dart';
import 'package:yoga_app/Widgets/custom_small_card_bottom_title.dart';

class DietHomeScreen extends StatelessWidget {
  DietHomeScreen({super.key});

  final RecommendedDietController recommendedDietController = Get.put(RecommendedDietController());
  final PopularDietController popularDietController = Get.put(PopularDietController());
  final YouMustTryDietController youMustTryDietController = Get.put(YouMustTryDietController());


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.dietTheme,
        title: const Text("Diet",style: TextStyle(color: Colors.white),),
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
            color: AppColors.dietTheme,
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
                      child: CustomDietVerticalTabs(themeColor: AppColors.dietTheme, vtab1: 'Breakfast', vtab2: 'Lunch', vtab3: 'Dinner')
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "Recommended For You"),
                      TextButton(onPressed: (){
                        Get.to(() => const RecommendedDietList());
                      }, child: Text("See All",style: TextStyle(color: AppColors.dietTheme),))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.12,
                    child: Obx(() {
                      if (recommendedDietController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (recommendedDietController.recommendedDietList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final item = recommendedDietController.recommendedDietList[index];
                          return CustomSmallCardBottomTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            subTitle: item.category ?? "",
                            onTap: () {Get.to(() => DietDetailScreen(title: item.title ?? "", id: item.id ?? ""));},

                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "You Must Try"),
                      TextButton(onPressed: (){
                        Get.to(() => const YouMustTryDietList());
                      }, child: Text("See All",style: TextStyle(color: AppColors.dietTheme),))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.15,
                    child: Obx(() {
                      if (youMustTryDietController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (youMustTryDietController.youMustTryDietList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final item = youMustTryDietController.youMustTryDietList[index];
                          return CustomMediumCardBottomTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            subTitle: item.category ?? "",
                            onTap: () {Get.to(() => DietDetailScreen(title: item.title ?? "", id: item.id ?? ""));},

                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSectionTitle(title: "Popular"),
                      TextButton(onPressed: (){
                        Get.to(() => const PopularDietList());
                      }, child: Text("See All",style: TextStyle(color: AppColors.dietTheme),))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.20,
                    child: Obx(() {
                      if (popularDietController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (popularDietController.popularDietList.isEmpty) {
                        return const Center(child: Text("No Data"));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final item = popularDietController.popularDietList[index];
                          return CustomLargeCardBottomTitle(
                            image: item.img ?? "",
                            title: item.title ?? "",
                            subTitle: item.category ?? "",
                            onTap: () {Get.to(() => DietDetailScreen(title: item.title ?? "", id: item.id ?? ""));},

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
