import 'package:flutter/material.dart';
import 'package:test_app/utils/widgets/buttons/mybutton.dart';

// ignore: camel_case_types
class customRow extends StatelessWidget {
  const customRow(
      {super.key,
      required this.size,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.colorText1,
      required this.colorText2,
      required this.colorText3,
      required this.onPressed1,
      this.onPressed2,
      this.onPressed3,
      required this.isDark});

  final Size size;
  final String text1;
  final String text2;
  final String text3;
  final Color colorText1;
  final Color colorText2;
  final Color colorText3;
  final bool isDark;
  final Function()? onPressed1;
  final Function()? onPressed2;
  final Function()? onPressed3;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Button(
          isDark: isDark,
          size: size,
          text: text1,
          colorText: colorText1,
          onPressed: onPressed1,
        ),
        const SizedBox(
          width: 5,
        ),
        Button(
          isDark: isDark,
          size: size,
          text: text2,
          colorText: colorText2,
          onPressed: onPressed2,
        ),
        const SizedBox(
          width: 5,
        ),
        Button(
          isDark: isDark,
          size: size,
          text: text3,
          colorText: colorText3,
          onPressed: onPressed3,
        ),
      ],
    );
  }
}
