import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/controllers/number_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';

// ignore: must_be_immutable
class ConverstionWidget extends StatelessWidget {
  ConverstionWidget({
    super.key,
    required this.numController,
  });
  ThemeController controller = Get.put(ThemeController());
  final ControllerText numController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: TextField(
                    onChanged: (String value) {
                      numController.firstNumber.value = value;
                      numController.convertCurrency();
                    },
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.labelSmall,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.edit),
                      hintText: '0.0',
                      hintStyle: Theme.of(context).textTheme.labelSmall,
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none //<-- SEE HERE
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Obx(() => DropdownButton<String>(
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      dropdownColor: controller.isDarkMode.value
                          ? const Color.fromARGB(255, 167, 230, 219)
                          : const Color.fromARGB(255, 250, 213, 213),
                      style: Theme.of(context).textTheme.labelSmall,
                      underline: const SizedBox(),
                      value: numController.firstCurrency.value,
                      onChanged: numController.updateFirstCurrency,
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'JPY',
                        'CAD',
                        'AUD',
                        'DZD'
                      ]
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    )),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              onPressed: numController.swapCurrencies,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Obx(() => TextField(
                          style: Theme.of(context).textTheme.labelSmall,
                          controller: TextEditingController(
                              text: numController.secondNumber.value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '0.0',
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none //<-- SEE HERE
                                ),
                          ),
                          readOnly: true,
                        )),
                  ),
                ),
                Obx(() => DropdownButton<String>(
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      dropdownColor: controller.isDarkMode.value
                          ? const Color.fromARGB(255, 167, 230, 219)
                          : const Color.fromARGB(255, 250, 213, 213),
                      underline: const SizedBox(),
                      style: Theme.of(context).textTheme.labelSmall,
                      value: numController.secondCurrency.value,
                      onChanged: numController.updateSecondCurrency,
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'JPY',
                        'CAD',
                        'AUD',
                        'DZD'
                      ]
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExchangeContainer extends StatelessWidget {
  const ExchangeContainer({
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
    return Container(
      width: double.infinity,
      height: size.height * 0.25,
      decoration: BoxDecoration(
          gradient: controller.isDarkMode.value
              ? const LinearGradient(colors: [
                  Color(0xff26debe),
                  Color.fromARGB(255, 102, 231, 210)
                ])
              : const LinearGradient(colors: [
                  Color(0xffff807f),
                  Color.fromARGB(255, 255, 171, 171)
                ]),
          borderRadius: const BorderRadius.all(Radius.circular(23))),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: 20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withOpacity(0.13),
                  borderRadius: const BorderRadius.all(Radius.circular(75))),
            ),
          ),
          Positioned(
            top: 100,
            right: 35,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withOpacity(0.13),
                  borderRadius: const BorderRadius.all(Radius.circular(75))),
            ),
          ),
          ConverstionWidget(numController: numController),
        ],
      ),
    );
  }
}
