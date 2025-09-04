import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga_app/Controller/detail_yoga_controller.dart';

class YogaDetailScreen extends StatelessWidget {
  final String image;
  final String title;
  final String id;

  YogaDetailScreen({
    super.key,
    required this.image,
    required this.title,
    required this.id,
  });

  late final DetailYogaController detailYogaController =
  Get.put(DetailYogaController(id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Text(
            "Up Next",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (detailYogaController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final yogaDetail = detailYogaController.yogaDetail.value;

              if (yogaDetail == null || yogaDetail.upNext == null || yogaDetail.upNext!.isEmpty) {
                return const Center(child: Text("No Up Next Yoga"));
              }

              var upNextList = yogaDetail.upNext!;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: upNextList.length,
                itemBuilder: (context, index) {
                  var yoga = upNextList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.network(
                            yoga.img ?? "",
                            height: 80,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                yoga.title ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                yoga.category ?? "",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                yoga.subCategory ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
