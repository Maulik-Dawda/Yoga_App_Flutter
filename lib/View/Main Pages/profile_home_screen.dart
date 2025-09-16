import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/Controller/popular_yoga_list_controller.dart';
import 'package:yoga_app/Controller/new_meditation_controller.dart';
import 'package:yoga_app/Controller/popular_diet_controller.dart';
import 'package:yoga_app/View/Auth%20Pages/login.dart';
import 'package:yoga_app/View/Detail%20Pages/diet_detail_screen.dart';
import 'package:yoga_app/View/Detail%20Pages/meditation_detail_screen.dart';
import 'package:yoga_app/View/Detail%20Pages/yoga_detail_screen.dart';
import '../../Widgets/custom_small_card_center_title.dart';

class ProfileHomeScreen extends StatefulWidget {
  const ProfileHomeScreen({super.key});

  @override
  State<ProfileHomeScreen> createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {
  String name = "";
  String email = "";

  final yogaController = Get.put(PopularYogaListController());
  final meditationController = Get.put(NewMeditationController());
  final dietController = Get.put(PopularDietController());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("username") ?? "No Name";
      email = prefs.getString("email") ?? "No Email";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.profileTheme,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              color: AppColors.profileTheme,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      size: 60, color: AppColors.profileTheme),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
      
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Your Yoga",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: screenHeight * 0.01,) ,
                    Obx(() {
                      if (yogaController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (yogaController.popularYogaList.isEmpty) {
                        return const Center(child: Text("No Yoga Found"));
                      }

                      final list = yogaController.popularYogaList.toList();
                      list.shuffle(Random());
                      final limited = list.take(6).toList();

                      return SizedBox(
                        height: screenHeight * 0.15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: limited.length,
                          itemBuilder: (context, index) {
                            final item = limited[index];
                            return CustomSmallCardCenterTitle(
                              image: item.img ?? "",
                              title: item.title ?? "", onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => YogaDetailScreen(title: item.title ?? "", id: item.id ??"")));
                            },
                            );
                          },
                        ),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.01,) ,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Your Meditations",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: screenHeight * 0.01,) ,
                    Obx(() {
                      if (meditationController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (meditationController.newMeditationList.isEmpty) {
                        return const Center(child: Text("No Meditation Found"));
                      }

                      final list = meditationController.newMeditationList.toList();
                      list.shuffle(Random());
                      final limited = list.take(6).toList();

                      return SizedBox(
                        height: screenHeight * 0.15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: limited.length,
                          itemBuilder: (context, index) {
                            final item = limited[index];
                            return CustomSmallCardCenterTitle(
                              image: item.img ?? "",
                              title: item.title ?? "", onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MeditationDetailScreen(title: item.title ?? "", id: item.id ??"")));

                            },
                            );
                          },
                        ),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.01,) ,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Your Diets",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: screenHeight * 0.01,) ,
                    Obx(() {
                      if (dietController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (dietController.popularDietList.isEmpty) {
                        return const Center(child: Text("No Diet Found"));
                      }

                      final list = dietController.popularDietList.toList();
                      list.shuffle(Random());
                      final limited = list.take(6).toList();

                      return SizedBox(
                        height: screenHeight * 0.15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: limited.length,
                          itemBuilder: (context, index) {
                            final item = limited[index];
                            return CustomSmallCardCenterTitle(
                              image: item.img ?? "",
                              title: item.title ?? "",
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DietDetailScreen(title: item.title ?? "", id: item.id ??"")));

                              },
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
