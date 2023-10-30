import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/utils/const/app_constants.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/language_controller.dart';

import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/services/messages.dart';
import 'package:test_app/utils/themes/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/utils/view/splash_Screen.dart';
import 'utils/services/dependency_inj.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  final ThemeController themeController = Get.put(ThemeController());
  // ignore: no_leading_underscores_for_local_identifiers
  Map<String, Map<String, String>> _languages = await dep.init();
  await themeController.initTheme();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp(languages: _languages)));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen());
    });
  }
}
