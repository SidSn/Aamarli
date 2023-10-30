import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/number_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/widgets/customWidgets/custom_row.dart';

// ignore: camel_case_types
class custom_keyboard extends StatelessWidget {
  const custom_keyboard({
    super.key,
    required this.size,
    required this.controller,
    required this.numController,
  });

  final Size size;
  final ThemeController controller;
  final ControllerText numController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: size.height * 0.46,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                offset: const Offset(1, -2),
                color: Colors.black.withOpacity(0.2))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: controller.isDarkMode.value
              ? secondaryColor
              : const Color(0xfff7f7f6),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: Column(
              children: [
                customRow(
                  isDark: controller.isDarkMode.value,
                  size: size,
                  text1: 'english'.tr,
                  text2: 'French'.tr,
                  text3: 'arabic'.tr,
                  colorText1: textColorThird,
                  colorText2: textColorThird,
                  colorText3: textColorThird,
                  onPressed1: () {
                    numController.lang.value = 1;
                    numController.converterToNumbers();
                  },
                  onPressed2: () {
                    numController.lang.value = 2;
                    numController.converterToNumbers();
                  },
                  onPressed3: () {
                    numController.converterToNumbers();
                    numController.lang.value = 3;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                customRow(
                    colorText1: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    colorText2: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    colorText3: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    isDark: controller.isDarkMode.value,
                    size: size,
                    text1: '7',
                    text2: '8',
                    text3: '9',
                    onPressed1: () {
                      numController.addNumber('7');
                    },
                    onPressed2: () {
                      numController.addNumber('8');
                    },
                    onPressed3: () {
                      numController.addNumber('9');
                    }),
                const SizedBox(
                  height: 5,
                ),
                customRow(
                    isDark: controller.isDarkMode.value,
                    colorText1: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    colorText2: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    colorText3: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    size: size,
                    text1: '4',
                    text2: '5',
                    text3: '6',
                    onPressed1: () {
                      numController.addNumber('4');
                    },
                    onPressed2: () {
                      numController.addNumber('5');
                    },
                    onPressed3: () {
                      numController.addNumber('6');
                    }),
                const SizedBox(
                  height: 5,
                ),
                customRow(
                  isDark: controller.isDarkMode.value,
                  size: size,
                  text1: '1',
                  text2: '2',
                  text3: '3',
                  onPressed1: () {
                    numController.addNumber('1');
                  },
                  onPressed2: () {
                    numController.addNumber('2');
                  },
                  onPressed3: () {
                    numController.addNumber('3');
                  },
                  colorText1:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                  colorText2:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                  colorText3:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                customRow(
                    colorText2: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    isDark: controller.isDarkMode.value,
                    size: size,
                    text1: 'delete'.tr,
                    text2: '0',
                    text3: 'clear'.tr,
                    colorText1: textColorSecondary,
                    colorText3: textColorSecondary,
                    onPressed1: () {
                      if (numController.userInput.value.length == 1) {
                        numController.converted.value = "";
                        numController.subNumber();
                      } else {
                        numController.subNumber();
                      }
                    },
                    onPressed2: () {
                      numController.addNumber('0');
                    },
                    onPressed3: () {
                      numController.userInput.value = '';
                      numController.converted.value = '';
                    }),
              ],
            )),
      ),
    );
  }
}
