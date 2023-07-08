import 'package:artifitia_machine_test/data/api/apis.dart';
import 'package:artifitia_machine_test/model/weather_model.dart';
import 'package:artifitia_machine_test/service/api_response.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MainController extends GetxController {
  static MainController instance = Get.find();

  String? dataFromLocal;
  Box? box;
  @override
  void onInit() async {
    box = await Hive.openBox('weather');

    super.onInit();
  }

  WeatherModel? weatherData;
  // void getLocationData() {
  //   Apis.getLocationData();
  // }

  APIResponse weatherApiResponse = APIResponse(data: null);
  void getIp() {
    weatherApiResponse = APIResponse(data: null, loading: true);
    update();
    Apis.getPublicIP();
  }
}
