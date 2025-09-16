import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/recommended_meditation_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';
import 'package:yoga_app/View/Detail%20Pages/meditation_detail_screen.dart';

class RecommendedMeditationList extends StatelessWidget {
  const RecommendedMeditationList({super.key});

  @override
  Widget build(BuildContext context) {
    final RecommendedMeditationController controller = Get.put(RecommendedMeditationController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.meditationTheme,
        elevation: 0,
        title: const Text(
          "New Meditation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.recommendedMeditationList.isEmpty) {
          return const Center(
              child: Text("No Meditation Data", style: TextStyle(fontSize: 16)));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GridView.builder(
            itemCount: controller.recommendedMeditationList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = controller.recommendedMeditationList[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to next meditation detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MeditationDetailScreen(
                            title: item.title ?? "",
                            id: item.id ?? "",
                          ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            item.img ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey[300], child: const Icon(Icons.image, size: 40)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.category ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
