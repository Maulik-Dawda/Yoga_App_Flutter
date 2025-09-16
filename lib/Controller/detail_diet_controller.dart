import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoga_app/Model/diet_detail_model.dart';

class DetailDietController extends GetxController {
  final String id;
  DetailDietController(this.id);

  Rx<DietDetailModel?> dietDetail = Rx<DietDetailModel?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getDietDetail();
    super.onInit();
  }

  Future<void> getDietDetail() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse(
          "https://mapi.trycatchtech.com/v3/yoga_app/single_diet?diet_id=$id",
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        dietDetail.value = DietDetailModel.fromJson(jsonMap);
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
