import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/yoga_list_model.dart';

class YogaListCategoryWiseController extends GetxController {
  final String category;
  final String subCategory;
  YogaListCategoryWiseController(this.category, this.subCategory);

  RxList<YogaListModel> yogaListCategoryWise =
      <YogaListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getYogaListCategoryWise();
    super.onInit();
  }

  Future<void> getYogaListCategoryWise() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/yoga_list_by_categories?category=$category&&sub_category=$subCategory"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        yogaListCategoryWise.assignAll(
          jsonList.map((json) => YogaListModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
