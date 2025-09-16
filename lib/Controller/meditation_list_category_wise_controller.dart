import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/meditation_list_model.dart';

class MeditationListCategoryWiseController extends GetxController {
  final String subCategory;
  MeditationListCategoryWiseController(this.subCategory);

  RxList<MeditationListModel> meditationListCategoryWise =
      <MeditationListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getMeditationListCategoryWise();
    super.onInit();
  }

  Future<void> getMeditationListCategoryWise() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/meditation_list_by_categories?category=$subCategory"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        meditationListCategoryWise.assignAll(
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
