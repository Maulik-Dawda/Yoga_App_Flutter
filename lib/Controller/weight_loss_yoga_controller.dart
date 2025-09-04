import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/yoga_list_model.dart';

class WeightLossYogaController extends GetxController {
  RxList<YogaListModel> weightLossYogaList =
      <YogaListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getYogaList();
    super.onInit();
  }

  Future<void> getYogaList() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/weight_loss_yoga"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        weightLossYogaList.assignAll(
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
