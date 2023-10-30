import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.size,
    required this.text,
    this.colorText = Colors.white,
    this.onPressed,
    required this.isDark,
  });
  final String text;
  final Size size;
  final Function()? onPressed;
  final bool isDark;
  // ignore: prefer_typing_uninitialized_variables
  final colorText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: size.height * 0.07,
          width: size.height * 0.14,
          decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xff23242d)
                  : const Color.fromARGB(255, 238, 238, 238),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: colorText),
            ),
          )),
    );
  }
}
