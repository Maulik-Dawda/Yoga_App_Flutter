import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/detail_yoga_page_model.dart';

class DetailYogaController extends GetxController {
  final String id;
  DetailYogaController(this.id);

  Rx<DetailYogaPageModel?> yogaDetail = Rx<DetailYogaPageModel?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getYogaDetail();
    super.onInit();
  }

  Future<void> getYogaDetail() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse(
          "https://mapi.trycatchtech.com/v3/yoga_app/single_yoga?yoga_id=$id",
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        yogaDetail.value = DetailYogaPageModel.fromJson(jsonMap);
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
