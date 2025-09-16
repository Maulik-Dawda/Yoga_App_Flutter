import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/meditation_detail_model.dart';

class DetailMeditationController extends GetxController {
  final String id;
  DetailMeditationController(this.id);

  Rx<MeditationDetailModel?> meditationDetail = Rx<MeditationDetailModel?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getMeditationDetail();
    super.onInit();
  }

  Future<void> getMeditationDetail() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse(
          "https://mapi.trycatchtech.com/v3/yoga_app/single_meditation?meditation_id=$id",
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        meditationDetail.value = MeditationDetailModel.fromJson(jsonMap);
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
