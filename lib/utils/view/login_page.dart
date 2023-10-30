// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dark_light_button/dark_light_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/language_controller.dart';

import 'package:test_app/utils/controllers/theme_controller.dart';

import 'package:test_app/utils/view/signup_page.dart';
import 'package:test_app/utils/widgets/bottomSheet/bottom_sheet_custom.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  ThemeController controller = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LocalizationController localizationController =
      Get.put(LocalizationController(sharedPreferences: Get.find()));
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ForgetPasswordBottomSheet.buildBottomSheet(context);
            },
            icon: const Icon(Icons.language)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DarlightButton(
              type: Darlights.DarlightOne,
              onChange: (value) {
                controller.toggleTheme();
              },
              options: DarlightOneOption(
                  lightBackGroundColor: textColorThird,
                  lightIconColor: secondaryColor,
                  lightIconBackgroundColor: secondarylight,
                  darkBackGroundColor: textColorSecondary,
                  darkIconColor: Colors.white,
                  darkIconBackgroundColor: secondaryColor),
            ),
          ),
        ],
      ),
      backgroundColor:
          controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.18,
              ),
              Text(
                "welcomeback".tr + ",",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "singinsub".tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              Form(
                  child: Column(
                children: [
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
                    height: 24,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      cursorColor: const Color(0xff4f4f4f),
                      obscureText: !authController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: 'password'.tr,
                        fillColor: controller.isDarkMode.value
                            ? secondaryColor
                            : secondarylight,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // Toggle password visibility
                            authController.isPasswordVisible.toggle();
                          },
                          child: Obx(
                            () => Icon(
                              authController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              )),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: ((context) {
                        return BottomSheetCustom(controller: controller);
                      }));
                },
                child: Padding(
                  padding: localizationController.isCurrentLanguageFrench()
                      ? EdgeInsets.only(left: size.width * 0.5, top: 12)
                      : EdgeInsets.only(left: size.width * 0.55, top: 12),
                  child: Text(
                    "forgotpass".tr,
                    style: TextStyle(
                        color: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              GestureDetector(
                onTap: () {
                  String email = emailController.text
                      .trim(); // Get the email from the TextField
                  String password = passwordController.text;
                  if (email.isEmpty || password.isEmpty) {
                    Get.snackbar('Error',
                        'Please enter both email and password fields.');
                  } else {
                    authController.signIn(email, password);
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
                    child: Center(child: Obx(() {
                      return authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                              'signin'.tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                    })),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.off(() => SignUp());
                },
                child: RichText(
                    text: TextSpan(
                        text: 'donthav'.tr,
                        style: TextStyle(
                          color: controller.isDarkMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        children: [
                      const TextSpan(text: " "),
                      TextSpan(
                          text: 'signup'.tr,
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? textColorSecondary
                                : textColorThird,
                          ))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
