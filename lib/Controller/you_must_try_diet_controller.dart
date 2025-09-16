import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/diet_list_model.dart';

class YouMustTryDietController extends GetxController {
  RxList<DietListModel> youMustTryDietList =
      <DietListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getYouMustTryDietList();
    super.onInit();
  }

  Future<void> getYouMustTryDietList() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/you_must_try_diet"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        youMustTryDietList.assignAll(
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
