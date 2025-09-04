import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/weight_loss_yoga_controller.dart';
import 'package:yoga_app/Themes/app_colors.dart';

class WeightLossYogaList extends StatelessWidget {
  const WeightLossYogaList({super.key});

  @override
  Widget build(BuildContext context) {
    final WeightLossYogaController controller = Get.put(WeightLossYogaController());

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.yogaTheme,
        elevation: 0,
        title: const Text(
          "Weight Loss Yoga",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.weightLossYogaList.isEmpty) {
          return const Center(
              child: Text("No Yoga Data", style: TextStyle(fontSize: 16)));
        }
        return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: controller.weightLossYogaList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = controller.weightLossYogaList[index];
              return Container(
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
                            "${item.subCategory ?? ""} | ${item.category ?? ""}",
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
              );
            },
          ),
        );
      }),
    );
  }
}
