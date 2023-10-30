import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/app_constants.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/language_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/models/language_model.dart';

// ignore: must_be_immutable
class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  ThemeController controller = Get.put(ThemeController());
  final int index;

  LanguageWidget(
      {super.key,
      required this.languageModel,
      required this.localizationController,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode,
            AppConstants.languages[index].countryCode,
          ));
          localizationController.setSelectedIndex(index);
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      languageModel.languageName,
                      style: TextStyle(
                          fontSize: 20,
                          color: localizationController.selectedIndex == index
                              ? controller.isDarkMode.value
                                  ? textColorSecondary
                                  : textColorThird
                              : controller.isDarkMode.value
                                  ? secondarylight
                                  : secondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
