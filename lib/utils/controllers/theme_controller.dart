import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/utils/themes/theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  var themeIcon = Icons.wb_sunny.obs;
  bool get currentTheme => isDarkMode.value;
  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
    themeIcon.value =
        isDarkMode.value ? Icons.wb_sunny : Icons.nightlight_round;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }

  Future<void> initTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkModePreference = prefs.getBool('isDarkMode') ?? false;
    isDarkMode.value = isDarkModePreference;
    Get.changeTheme(isDarkModePreference ? darkTheme : lightTheme);
  }
}
