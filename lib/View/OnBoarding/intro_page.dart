import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yoga_app/View/Main%20Pages/yoga_home_screen.dart';
import 'package:yoga_app/Widgets/custom_intro_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: const [
              CustomIntroScreen(
                image: "assets/images/first_intro.png",
                title: "Stop Wishing And Get Fit",
                description:
                "Stop waiting for tomorrow, take action today, embrace discipline, build strength, stay consistent, and transform your fitness journey completely.",
              ),
              CustomIntroScreen(
                image: "assets/images/second_intro.png",
                title: "Time To Yoga",
                description:
                "Discover balance and harmony through yoga. Stretch, strengthen, breathe deeply, and rejuvenate body, mind, and soul with mindful practice daily.",
              ),
              CustomIntroScreen(
                image: "assets/images/third_intro.png",
                title: "Meditation And Relax",
                description:
                "Calm your restless thoughts, release stress, embrace mindfulness, meditate daily, and unlock inner peace, relaxation, and clarity for life’s balance.",
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            alignment: Alignment.bottomCenter,
            child: isLastPage
                ? ElevatedButton(
              onPressed: () {
               Get.to(() => YogaHomeScreen());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF6A5ACD),
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 16),
              ),
            )
                : SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const WormEffect(
                spacing: 20,
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Color(0xFF6A5ACD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
