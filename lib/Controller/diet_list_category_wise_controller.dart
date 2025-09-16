import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/diet_list_model.dart';

class DietListCategoryWiseController extends GetxController {
  final String subCategory;
  DietListCategoryWiseController(this.subCategory);

  RxList<DietListModel> dietListCategoryWise =
      <DietListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getDietListCategoryWise();
    super.onInit();
  }

  Future<void> getDietListCategoryWise() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/diet_list_by_categories?category=$subCategory"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        dietListCategoryWise.assignAll(
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
