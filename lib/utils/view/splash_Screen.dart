// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/const/images.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/view/login_page.dart';
import 'package:test_app/utils/view/home_page.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wait for 2 seconds (or any desired duration) before navigating
    Future.delayed(const Duration(seconds: 2), () {
      final AuthController authController = Get.find<AuthController>();
      if (authController.user.value == null) {
        Get.off(() => LoginPage()); // Navigate to login page
      } else {
        Get.off(() => MyHomePage()); // Navigate to home page
      }
    });

    return Screen();
  }
}

// ignore: must_be_immutable
class Screen extends StatelessWidget {
  Screen({super.key});
  ThemeController controller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
      body: Center(
        child: controller.isDarkMode.value
            ? Image.asset(
                logo1,
                width: 200,
                height: 200,
              )
            : Image.asset(
                logo2,
                width: 200,
                height: 200,
              ),
      ),
    );
  }
}
