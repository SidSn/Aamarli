// ignore_for_file: file_names, depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/language_controller.dart';

import 'package:test_app/utils/controllers/number_controller.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/view/converter_page.dart';
import 'package:test_app/utils/view/exchange_rates_page.dart';

import 'package:test_app/utils/widgets/menu/drawer_menu.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  ThemeController controller = Get.put(ThemeController());
  ControllerText numController = Get.put(ControllerText());
  AuthController authController = Get.put(AuthController());
  ProfileController profilController = Get.put(ProfileController());
  LocalizationController localizationController =
      Get.put(LocalizationController(sharedPreferences: Get.find()));
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor:
            controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
        drawer: CustomDrawer(controller: controller),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Obx(() {
                        if (profilController.userProfile.value != null) {
                          String userName = profilController.userProfile.value![
                              'fullName']; // Assuming 'fullName' is the key in your Firestore document
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "welcome".tr + " " + '$userName!',
                              style: Theme.of(context).textTheme.headlineSmall,
                              maxLines: 2,
                            ),
                          );
                        } else {
                          return const Text('Loading...');
                        }
                      }),
                    ),
                    Text(
                      "make".tr,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: controller.isDarkMode.value
                          ? secondaryColor
                          : const Color(0xfff7f7f7),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            offset: const Offset(1, -2),
                            color: Colors.black.withOpacity(0.2))
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Text(
                    "algeriandinar".tr,
                    style: TextStyle(
                        color: controller.isDarkMode.value
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.2,
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: controller.isDarkMode.value
                                  ? const Color(0xff26debe).withOpacity(0.13)
                                  : const Color(0xffff807f).withOpacity(0.13),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Obx(
                            () => Text(
                              "dollar".tr +
                                  " " +
                                  numController.usdtoDzd.value +
                                  " " +
                                  "dzd".tr,
                              style: TextStyle(
                                  color: controller.isDarkMode.value
                                      ? const Color(0xff26debe)
                                      : const Color(0xffff807f),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: controller.isDarkMode.value
                                  ? const Color(0xff26debe).withOpacity(0.13)
                                  : const Color(0xffff807f).withOpacity(0.13),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Obx(
                            () => Text(
                              "euro".tr +
                                  " " +
                                  numController.eurotoDzd.value +
                                  " " +
                                  "dzd".tr,
                              style: TextStyle(
                                  color: controller.isDarkMode.value
                                      ? const Color(0xff26debe)
                                      : const Color(0xffff807f),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              Container(
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    color: controller.isDarkMode.value
                        ? secondaryColor
                        : const Color(0xfff7f7f7),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          offset: const Offset(1, -2),
                          color: Colors.black.withOpacity(0.2))
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * .02),
                      Text(
                        "Converter".tr,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "subtext1".tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ConverterPage(),
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Padding(
                          padding: localizationController
                                  .isCurrentLanguageFrench()
                              ? EdgeInsets.only(left: size.width * .28)
                              : localizationController.isCurrentLanguageArabic()
                                  ? EdgeInsets.only(right: size.width * .55)
                                  : EdgeInsets.only(left: size.width * .4),
                          child: Container(
                            padding:
                                localizationController.isCurrentLanguageArabic()
                                    ? const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 34)
                                    : const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                                color: controller.isDarkMode.value
                                    ? const Color(0xff26debe)
                                    : const Color(0xffff807f),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              'btn1'.tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: localizationController.isCurrentLanguageFrench()
                            ? 10
                            : 16,
                      ),
                      Text(
                        "exchange".tr,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "subtext1".tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: localizationController.isCurrentLanguageFrench()
                            ? 10
                            : 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ExchangeRatesPage(),
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Padding(
                          padding: localizationController
                                  .isCurrentLanguageFrench()
                              ? EdgeInsets.only(left: size.width * .48)
                              : localizationController.isCurrentLanguageArabic()
                                  ? EdgeInsets.only(right: size.width * .52)
                                  : EdgeInsets.only(left: size.width * .51),
                          child: Container(
                            padding:
                                localizationController.isCurrentLanguageArabic()
                                    ? const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 34)
                                    : const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                                color: controller.isDarkMode.value
                                    ? const Color(0xff26debe)
                                    : const Color(0xffff807f),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              'btn2'.tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
