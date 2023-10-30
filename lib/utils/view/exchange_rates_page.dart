import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/const/images.dart';
import 'package:test_app/utils/controllers/conversion_controller.dart';

import 'package:test_app/utils/controllers/number_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/widgets/customWidgets/conversion_widget.dart';

// ignore: must_be_immutable
class ExchangeRatesPage extends StatelessWidget {
  ExchangeRatesPage({super.key});
  ThemeController controller = Get.put(ThemeController());
  ControllerText numController = Get.put(ControllerText());
  ConvertController convertController = Get.put(ConvertController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'exchange'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      backgroundColor:
          controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, right: 16, left: 16),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              ExchangeContainer(
                  size: size,
                  controller: controller,
                  numController: numController),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "subCon".tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Obx(
                () => ExchangeListItem(
                  controller: controller,
                  title: 'usa'.tr,
                  flag: usa,
                  value: convertController.usdtoDzd.value,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(
                () => ExchangeListItem(
                  controller: controller,
                  title: 'eur'.tr,
                  flag: euro,
                  value: convertController.eurotoDzd.value,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(
                () => ExchangeListItem(
                  controller: controller,
                  title: 'cad'.tr,
                  flag: cad,
                  value: convertController.cadtoDzd.value,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(
                () => ExchangeListItem(
                  controller: controller,
                  title: 'gbp'.tr,
                  flag: gp,
                  value: convertController.gptoDzd.value,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(
                () => ExchangeListItem(
                  controller: controller,
                  title: 'au'.tr,
                  flag: aus,
                  value: convertController.austoDzd.value,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Obx(
                () => ExchangeListItem(
                  controller: controller,
                  title: 'jap'.tr,
                  flag: jap,
                  value: convertController.jptoDzd.value,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ExchangeListItem extends StatelessWidget {
  const ExchangeListItem({
    super.key,
    required this.controller,
    required this.title,
    required this.flag,
    required this.value,
  });

  final ThemeController controller;

  final String title;
  final String flag;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
        leading: Image.asset(
          flag,
          height: 35,
          width: 40,
          fit: BoxFit.cover,
        ),
        title: Text(title),
        // ignore: prefer_interpolation_to_compose_strings
        trailing: Text(value + " " + "dzd".tr),
      ),
    );
  }
}
