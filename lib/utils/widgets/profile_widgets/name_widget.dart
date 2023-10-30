import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';

class NameEditWidget extends StatelessWidget {
  const NameEditWidget({
    super.key,
    required this.controller,
    required ProfileController profileController,
    required TextEditingController fullNameController,
  })  : _profileController = profileController,
        _fullNameController = fullNameController;

  final ThemeController controller;
  final ProfileController _profileController;
  final TextEditingController _fullNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: controller.isDarkMode.value ? secondaryColor : bgColorLight,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  offset: const Offset(1, 2),
                  color: Colors.black.withOpacity(0.2))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: ListTile(
          leading: const Icon(
            Icons.person,
            size: 38,
          ),
          title: Text("name".tr),
          subtitle: Obx(() {
            if (_profileController.userProfile.value != null) {
              String userName =
                  _profileController.userProfile.value!['fullName'];
              return Text(userName);
            } else {
              return const Text('Loading...');
            }
          }),
          trailing: GestureDetector(
            onTap: () {
              Get.bottomSheet(Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: controller.isDarkMode.value ? bgColor : bgColorLight,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "name".tr,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextField(
                          controller: _fullNameController,
                          cursorColor: const Color(0xff4f4f4f),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            fillColor: controller.isDarkMode.value
                                ? secondaryColor
                                : secondarylight,
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            String fullname = _fullNameController.text.trim();
                            if (fullname.isNotEmpty) {
                              _profileController.updateUserProfile(fullname);
                              Get.back();
                            } else {
                              _profileController.updateUserProfile(
                                  _profileController
                                      .userProfile.value!['fullName']);
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
                              child: Center(
                                child: Text(
                                  'apply'.tr,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            },
            child: Icon(
              Icons.edit,
              color: controller.isDarkMode.value
                  ? textColorSecondary
                  : textColorThird,
            ),
          ),
        ),
      ),
    );
  }
}
