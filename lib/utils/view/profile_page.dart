import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';

import 'package:test_app/utils/controllers/theme_controller.dart';

import 'package:test_app/utils/widgets/profile_widgets/profile_pic_widget.dart';
import 'package:test_app/utils/widgets/profile_widgets/gender_widget.dart';
import 'package:test_app/utils/widgets/profile_widgets/name_widget.dart';
import 'package:test_app/utils/widgets/profile_widgets/phone_widget.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  ThemeController controller = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());
  final ProfileController _profileController = Get.put(ProfileController());
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // Default value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
        appBar: AppBar(
          title: Text(
            'profile'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 7,
                              offset: const Offset(1, 2),
                              color: Colors.black.withOpacity(0.2))
                        ],
                        color: controller.isDarkMode.value
                            ? const Color.fromARGB(255, 53, 59, 71)
                            : const Color(0xfff7f7f7),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                    child: ProfilePicWidget(
                      borderRaduis: 150,
                      raduis: 75,
                      height: 120,
                      width: 120,
                      authController: authController,
                      controller: controller,
                      fontsize: 75,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 180,
                    child: Obx(() {
                      if (_profileController.userProfile.value != null) {
                        String userName =
                            _profileController.userProfile.value!['fullName'];
                        String userEmail = _profileController
                                .userProfile.value![
                            'email']; // Assuming 'fullName' is the key in your Firestore document
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' $userName',
                              style: Theme.of(context).textTheme.headlineSmall,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            Text(
                              ' $userEmail',
                              style: Theme.of(context).textTheme.titleSmall,
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
            ),
            NameEditWidget(
                controller: controller,
                profileController: _profileController,
                fullNameController: _fullNameController),
            PhoneEditWidget(
                controller: controller,
                profileController: _profileController,
                phoneController: _phoneController),
            GenderEditWidget(
                controller: controller, profileController: _profileController),
            GestureDetector(
              onTap: () {
                _profileController.deleteProfilePictureFromStorage();
                _profileController.deleteUserInfoFromFirestore();
                authController.deleteAccount();
                authController.signOut();
              },
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Center(
                    child: Obx(() {
                      return authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                              'deleAcc'.tr,
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                    }),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
