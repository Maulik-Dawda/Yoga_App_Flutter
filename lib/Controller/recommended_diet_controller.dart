import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/diet_list_model.dart';

class RecommendedDietController extends GetxController {
  RxList<DietListModel> recommendedDietList =
      <DietListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getRecommendedDietList();
    super.onInit();
  }

  Future<void> getRecommendedDietList() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/recommended_diet"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        recommendedDietList.assignAll(
          jsonList.map((json) => DietListModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
