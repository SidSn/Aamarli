import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/language_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/widgets/buttons/lan_widget.dart';

// ignore: must_be_immutable
class BottomSheetCustom extends StatelessWidget {
  BottomSheetCustom({
    super.key,
    required this.controller,
  });

  final ThemeController controller;
  AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: controller.isDarkMode.value ? bgColor : bgColorLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "forgotpass".tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(style: Theme.of(context).textTheme.titleSmall, "pas".tr),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: emailController,
                cursorColor: const Color(0xff4f4f4f),
                decoration: InputDecoration(
                  hintText: 'email'.tr,
                  fillColor: controller.isDarkMode.value
                      ? secondaryColor
                      : secondarylight,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: controller.isDarkMode.value
                      ? textColorSecondary
                      : textColorThird,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  String email = emailController.text;
                  if (email.isEmpty) {
                    Get.snackbar("noemail".tr, "sub".tr);
                  } else {
                    authController.resetPassword(email);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Text(
                        'sendLink'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetCustomCode extends StatelessWidget {
  const BottomSheetCustomCode({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: controller.isDarkMode.value ? bgColor : bgColorLight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "linkSent".tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                  style: Theme.of(context).textTheme.titleSmall, "linktext".tr),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Text(
                        'back'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordBottomSheet {
  static Future<dynamic> buildBottomSheet(BuildContext context) {
    ThemeController controller = Get.put(ThemeController());
    return Get.bottomSheet(
      backgroundColor:
          controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<LocalizationController>(
            builder: (localizationController) {
              return Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('select'.tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => LanguageWidget(
                            languageModel:
                                localizationController.languages[index],
                            localizationController: localizationController,
                            index: index,
                          )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
