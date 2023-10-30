import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';

class PhoneEditWidget extends StatelessWidget {
  const PhoneEditWidget({
    super.key,
    required this.controller,
    required ProfileController profileController,
    required TextEditingController phoneController,
  })  : _profileController = profileController,
        _phoneController = phoneController;

  final ThemeController controller;
  final ProfileController _profileController;
  final TextEditingController _phoneController;

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
            Icons.phone,
            size: 38,
          ),
          title: Text("phone".tr),
          subtitle: Obx(() {
            if (_profileController.userProfile.value != null) {
              String userName = _profileController.userProfile.value!['phone'];
              return Text(userName);
            } else {
              return Text("phone".tr);
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
                          "phone".tr,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextField(
                          controller: _phoneController,
                          cursorColor: const Color(0xff4f4f4f),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'phone'.tr,
                            fillColor: controller.isDarkMode.value
                                ? secondaryColor
                                : secondarylight,
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.phone),
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
                            String phone = _phoneController.text.trim();
                            _profileController.addPhone(phone);
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
