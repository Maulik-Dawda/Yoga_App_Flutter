import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/diet_list_category_wise_controller.dart';
import 'package:yoga_app/View/Detail%20Pages/diet_detail_screen.dart';
import 'package:yoga_app/Widgets/custom_tab_card.dart';

class CustomDietListTab extends StatelessWidget {
  final String subCategory;

  const CustomDietListTab({
    super.key,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final DietListCategoryWiseController controller = Get.put(
      DietListCategoryWiseController(subCategory),
      tag: subCategory,
    );

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.dietListCategoryWise.isEmpty) {
        return const Center(child: Text("No Data"));
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: controller.dietListCategoryWise.length,
        itemBuilder: (context, index) {
          final item = controller.dietListCategoryWise[index];
          return CustomTabCard(
            image: item.img ?? "",
            title: item.title ?? "",
            subtitle: item.category ?? "",
            onTap: () {
              Get.to(
                    () => DietDetailScreen(
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
