import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/yoga_list_category_wise_controller.dart';
import 'package:yoga_app/View/Detail%20Pages/yoga_detail_screen.dart';
import 'package:yoga_app/Widgets/custom_tab_card.dart';

class CustomYogaListTab extends StatelessWidget {
  final String category;
  final String subCategory;

  const CustomYogaListTab({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final YogaListCategoryWiseController controller = Get.put(
      YogaListCategoryWiseController(category, subCategory),
      tag: "$category-$subCategory",
    );

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.yogaListCategoryWise.isEmpty) {
        return const Center(child: Text("No Data"));
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: controller.yogaListCategoryWise.length,
        itemBuilder: (context, index) {
          final item = controller.yogaListCategoryWise[index];
          return CustomTabCard(
            image: item.img ?? "",
            title: item.title ?? "",
            subtitle: "${item.subCategory ?? ""} | ${item.category ?? ""}",
            onTap: () {
              Get.to(
                () => YogaDetailScreen(
                  image: item.img ?? "",
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
