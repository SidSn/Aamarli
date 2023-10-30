// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dark_light_button/dark_light_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';

import 'package:test_app/utils/controllers/theme_controller.dart';

import 'package:test_app/utils/view/login_page.dart';
import 'package:test_app/utils/widgets/bottomSheet/bottom_sheet_custom.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});

  ThemeController controller = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                height: size.height * 0.05,
              ),
              Text(
                "welcome".tr + ',',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "signupsub".tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: fullNameController,
                    cursorColor: const Color(0xff4f4f4f),
                    decoration: InputDecoration(
                      hintText: 'name'.tr,
                      fillColor: controller.isDarkMode.value
                          ? secondaryColor
                          : secondarylight,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: controller.isDarkMode.value
                          ? textColorSecondary
                          : textColorThird,
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
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
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: confirmPasswordController,
                      cursorColor: const Color(0xff4f4f4f),
                      obscureText: !authController.isPasswordVisible2.value,
                      decoration: InputDecoration(
                        hintText: 'confirmpassword'.tr,
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
                            authController.isPasswordVisible2.toggle();
                          },
                          child: Obx(
                            () => Icon(
                              authController.isPasswordVisible2.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 28,
              ),
              GestureDetector(
                onTap: () {
                  String fullName = fullNameController.text
                      .trim(); // Get the full name from the TextField
                  String email = emailController.text
                      .trim(); // Get the email from the TextField
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  if (password.isEmpty || confirmPassword.isEmpty) {
                    Get.snackbar('Error', 'Please enter both password fields.');
                  } else if (password != confirmPassword) {
                    Get.snackbar('Error', 'Passwords do not match.');
                  } else {
                    authController.createUser(email, password, fullName);
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
                              'signup'.tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                    })),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.off(() => LoginPage());
                },
                child: RichText(
                    text: TextSpan(
                        text: 'haveacc'.tr,
                        style: TextStyle(
                          color: controller.isDarkMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        children: [
                      const TextSpan(text: " "),
                      TextSpan(
                          text: 'signin'.tr,
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
