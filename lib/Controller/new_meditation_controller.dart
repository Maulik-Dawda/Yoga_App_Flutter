import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/meditation_list_model.dart';

class NewMeditationController extends GetxController {
  RxList<MeditationListModel> newMeditationList =
      <MeditationListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getNewMeditationList();
    super.onInit();
  }

  Future<void> getNewMeditationList() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/yoga_app/new_meditation"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        newMeditationList.assignAll(
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
