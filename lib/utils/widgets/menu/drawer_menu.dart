// ignore: camel_case_types

// ignore_for_file: unnecessary_string_interpolations

import 'package:dark_light_button/dark_light_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/view/Home_page.dart';
import 'package:test_app/utils/view/converter_page.dart';
import 'package:test_app/utils/view/exchange_rates_page.dart';
import 'package:test_app/utils/view/history_page.dart';
import 'package:test_app/utils/view/profile_page.dart';
import 'package:test_app/utils/widgets/bottomSheet/bottom_sheet_custom.dart';
import 'package:test_app/utils/widgets/profile_widgets/profile_pic_widget.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    required this.controller,
  });

  final ThemeController controller;
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: controller.isDarkMode.value
          ? secondaryColor
          : const Color(0xfffefffe),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                    height: 170,
                    decoration: BoxDecoration(
                        color: controller.isDarkMode.value
                            ? textColorSecondary
                            : textColorThird,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -200,
                          right: -230,
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(250))),
                          ),
                        ),
                        Positioned(
                          top: -195,
                          right: -160,
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(250))),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfilePicWidget(
                              fontsize: 38,
                              height: 85,
                              width: 85,
                              authController: authController,
                              controller: controller,
                              borderRaduis: 50,
                              raduis: 37,
                            ),
                            SizedBox(
                              width: 180,
                              child: Obx(() {
                                if (profileController.userProfile.value !=
                                    null) {
                                  String userName = profileController
                                      .userProfile.value!['fullName'];
                                  String userEmail = profileController
                                          .userProfile.value![
                                      'email']; // Assuming 'fullName' is the key in your Firestore document
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                        '$userName',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        maxLines: 2,
                                        // overflow: TextOverflow.fade,
                                        // softWrap: false,
                                      ),
                                      Text(
                                        ' $userEmail',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Text('Loading...');
                                }
                              }),
                            ),
                          ],
                        ),
                      ],
                    )),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: Text('home'.tr),
                  onTap: () {
                    Get.to(() => MyHomePage(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 500));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.repeat),
                  title: Text('Converter'.tr),
                  onTap: () {
                    Get.to(() => ConverterPage(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 500));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on_outlined),
                  title: Text('exchange'.tr),
                  onTap: () {
                    Get.to(() => ExchangeRatesPage(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 500));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('profile'.tr),
                  onTap: () {
                    Get.to(() => ProfilePage(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 500));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: Text('history'.tr),
                  onTap: () {
                    Get.to(() => HistoryScreen(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 500));
                  },
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Row(
                    children: [
                      Text('apptheme'.tr),
                      const Spacer(),
                      DarlightButton(
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
                            darkIconBackgroundColor:
                                const Color.fromARGB(255, 28, 33, 44)),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('lang'.tr),
                  trailing: IconButton(
                      onPressed: () {
                        ForgetPasswordBottomSheet.buildBottomSheet(context);
                      },
                      icon: const Icon(Icons.language)),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              authController.signOut();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: controller.isDarkMode.value
                        ? textColorSecondary
                        : textColorThird,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(() {
                      return authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                              'logou'.tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                    })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
