import 'package:flutter/material.dart';
import 'package:yoga_app/Themes/app_colors.dart';

class YogaHomeScreen extends StatelessWidget {
  const YogaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.yogaTheme,
        title: const Text("YOGA", style: TextStyle(color: Colors.white)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: screenHeight * 0.01),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: AppColors.yogaTheme,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "WOMEN"),
                      Tab(text: "MEN"),
                    ],
                  ),
                  SizedBox(
                    height: 260,
                    child: TabBarView(
                      children: [
                        buildVerticalTabs(context),
                        buildVerticalTabs(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sectionTitle("Popular Yoga Exercise"),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                children: [
                  smallCard("Stay Active Fullday", "30 min | 10 poses", "assets/images/yoga3.png"),
                  smallCard("Winter Yoga", "30 min | 10 poses", "assets/images/yoga4.png"),
                ],
              ),
            ),
            sectionTitle("Recommended For You"),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                children: [
                  mediumCard("Morning Yoga", "30 min | 10 poses", "assets/images/yoga5.png"),
                  mediumCard("Push Your Limits", "30 min | 10 poses", "assets/images/yoga6.png"),
                  mediumCard("Stay Healthy", "30 min | 10 poses", "assets/images/yoga7.png"),
                ],
              ),
            ),
            sectionTitle("Yoga For Weight loss"),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                children: [
                  mediumCard("Selfcare", "30 min | 10 poses", "assets/images/yoga8.png"),
                  mediumCard("Let It Burn", "30 min | 10 poses", "assets/images/yoga9.png"),
                  mediumCard("Be Limitless", "30 min | 10 poses", "assets/images/yoga10.png"),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  static Widget buildVerticalTabs(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 220,
              child: const TabBar(
                dividerHeight: 0,
                labelColor: AppColors.yogaTheme,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.yogaTheme,
                tabs: [
                  Tab(text: "New"),
                  Tab(text: "Skilled"),
                  Tab(text: "Pro"),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 220,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(12),
                    children: [
                      yogaCard("Beginners Yoga Poses", "30 min | 10 poses", "assets/images/yoga1.png"),
                      yogaCard("10 Basic Yoga Poses", "30 min | 15 poses", "assets/images/yoga2.png"),
                    ],
                  ),
                  Center(child: Text("Skilled Yoga Workouts")),
                  Center(child: Text("Pro Yoga Workouts")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  static Widget yogaCard(String title, String subtitle, String img) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 12,
            bottom: 30,
            child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ),
          const Positioned(
            right: 12,
            bottom: 12,
            child: Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  static Widget smallCard(String title, String subtitle, String img) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }

  static Widget mediumCard(String title, String subtitle, String img) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
