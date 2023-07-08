import 'package:artifitia_machine_test/routes/app_pages.dart';
import 'package:artifitia_machine_test/widgets/fn_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Get.toNamed(AppPages.homeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: FnText(
          text: "Artifitia Flutter Assessment",
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
