import 'dart:convert';

import 'package:artifitia_machine_test/data/controller/main_controller.dart';
import 'package:artifitia_machine_test/helper/custom_print.dart';
import 'package:artifitia_machine_test/model/weather_model.dart';
import 'package:artifitia_machine_test/service/api_response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;

class Apis {
  static Future<void> getLocationData(String location) async {
    final ctr = MainController.instance;

    const key = "ed154aa5abfa45f28e574450230807";

    final response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$key&q=dubai"));

    customPrint(response.body);

    if (response.statusCode == 200) {
      WeatherModel weatherModel = weatherModelFromJson(response.body);
      ctr.weatherData = weatherModel;
      ctr.box?.put('waether', jsonEncode(weatherModel.toJson()));

      customPrint(ctr.weatherData?.location?.name);
    } else {
      Get.snackbar("error", "something went wrong");
    }
    ctr.weatherApiResponse = APIResponse(data: null, loading: false);

    MainController.instance.update();
  }

  static Future getPublicIP() async {
    try {
      const url = 'https://api.ipify.org?format=json';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // The response body is the IP in plain text, so just
        // return it as-is.
        customPrint(response.body);
        getLocation(jsonDecode(response.body)['ip']);
        return response.body;
      } else {
        // The request failed with a non-200 code
        // The ipify.org API has a lot of guaranteed uptime
        // promises, so this shouldn't ever actually happen.
      }
    } catch (e) {
      // Request failed due to an error, most likely because
      // the phone isn't connected to the internet.
    }
  }

  static Future getLocation(String ip) async {
    final url = "https://ipinfo.io/$ip/geo";
    var response = await http.get(Uri.parse(url));

    customPrint(jsonDecode(response.body));

    final data = jsonDecode(response.body)['city'];

    if (response.statusCode == 200) {
      getLocationData(data);
    }
  }
}
