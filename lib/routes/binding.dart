import 'package:artifitia_machine_test/data/controller/main_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
    // Get.put(ThemeController());
    MainController.instance.getIp();
  }
}
