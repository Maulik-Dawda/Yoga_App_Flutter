import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/meditation_list_model.dart';

class RecommendedMeditationController extends GetxController {
  RxList<MeditationListModel> recommendedMeditationList =
      <MeditationListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getRecommendedMeditationList();
    super.onInit();
  }

  Future<void> getRecommendedMeditationList() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/recommended_meditation"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        recommendedMeditationList.assignAll(
          jsonList.map((json) => MeditationListModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
