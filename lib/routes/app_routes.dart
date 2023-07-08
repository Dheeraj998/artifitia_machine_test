import 'package:artifitia_machine_test/pages/home_screen.dart';
import 'package:artifitia_machine_test/routes/app_pages.dart';
import 'package:artifitia_machine_test/routes/binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  Routes._();
  static final routes = [
    GetPage(
        name: AppPages.homeScreen,
        page: () => const HomeScreen(),
        binding: GeneralBindings()),
  ];
}
