import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/number_controller.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/widgets/customWidgets/custom_keyboard.dart';

// ignore: must_be_immutable
class ConverterPage extends StatelessWidget {
  ConverterPage({super.key});
  ThemeController controller = Get.put(ThemeController());
  ControllerText numController = Get.put(ControllerText());
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Converter'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(12.0),
              child: numController.userInput.value.isEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (numController.converted.value.isEmpty) {
                          return;
                        } else {
                          FlutterClipboard.copy(numController.converted.value)
                              .then((result) {
                            const snackBar = SnackBar(
                              content: Text('Copied to Clipboard'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                          profileController
                              .addHistoryRecord(numController.converted.value);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        decoration: BoxDecoration(
                            color: controller.isDarkMode.value
                                ? textColorSecondary
                                : textColorThird,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: const Text('Save & Copy'),
                      ),
                    ),
            ),
          ),
        ],
      ),
      backgroundColor:
          controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.048,
            ),
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                child: Column(
                  children: [
                    Obx(
                      () => Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            numController.userInput.value.isEmpty
                                ? const TextSpan()
                                : TextSpan(
                                    text: "\"",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                            TextSpan(
                              text: numController.converted.value,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            numController.userInput.value.isEmpty
                                ? const TextSpan()
                                : TextSpan(
                                    text: "\"",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                          ])),
                    ),
                    Obx(
                      () => Text(
                        numController.userInput.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            custom_keyboard(
                size: size,
                controller: controller,
                numController: numController)
          ],
        ),
      ),
    );
  }
}
