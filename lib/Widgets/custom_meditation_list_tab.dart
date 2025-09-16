import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/meditation_list_category_wise_controller.dart';
import 'package:yoga_app/View/Detail%20Pages/meditation_detail_screen.dart';
import 'package:yoga_app/Widgets/custom_tab_card.dart';

class CustomMeditationListTab extends StatelessWidget {
  final String subCategory;

  const CustomMeditationListTab({
    super.key,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final MeditationListCategoryWiseController controller = Get.put(
      MeditationListCategoryWiseController(subCategory),
      tag: subCategory,
    );

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.meditationListCategoryWise.isEmpty) {
        return const Center(child: Text("No Data"));
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: controller.meditationListCategoryWise.length,
        itemBuilder: (context, index) {
          final item = controller.meditationListCategoryWise[index];
          return CustomTabCard(
            image: item.img ?? "",
            title: item.title ?? "",
            subtitle: item.category ?? "",
            onTap: () {
              Get.to(
                    () => MeditationDetailScreen(
                  title: item.title ?? "",
                  id: item.id ?? "",
                ),
              );
            },
          );
        },
      );
    });
  }
}
