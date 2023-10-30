import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';

class GenderEditWidget extends StatelessWidget {
  const GenderEditWidget({
    super.key,
    required this.controller,
    required ProfileController profileController,
  }) : _profileController = profileController;

  final ThemeController controller;
  final ProfileController _profileController;

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
          title: Text("gender".tr),
          subtitle: Obx(() {
            if (_profileController.userProfile.value != null) {
              String userName = _profileController.userProfile.value!['gender'];
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
                          "gender".tr,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Obx(() => DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: controller.isDarkMode.value
                                  ? secondaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              value: _profileController.selectedGender.value,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  _profileController.setGender(newValue);
                                }
                              },
                              items: <String>['-', 'male'.tr, 'female'.tr]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _profileController.genderSelect(
                                _profileController.selectedGender.value);
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
