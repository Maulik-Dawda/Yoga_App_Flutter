import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/recommended_yoga_model.dart';

class RecommendedYogaController extends GetxController {
  RxList<RecommendedYogaModel> recommendedYogaList =
      <RecommendedYogaModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getRecommendedYogaList();
    super.onInit();
  }

  Future<void> getRecommendedYogaList() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/recommended_yoga"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        recommendedYogaList.assignAll(
          jsonList.map((json) => RecommendedYogaModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
