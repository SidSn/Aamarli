import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test_app/utils/controllers/auth_controller.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';

// ignore: must_be_immutable
class ProfilePicWidget extends StatelessWidget {
  ProfilePicWidget({
    super.key,
    required this.authController,
    required this.controller,
    required this.width,
    required this.height,
    required this.borderRaduis,
    required this.raduis,
    required this.fontsize,
  });

  final AuthController authController;
  final ThemeController controller;
  ProfileController profilController = Get.put(ProfileController());
  final double width;
  final double height;
  final double borderRaduis;
  final double raduis;

  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        profilController.uploadProfilePicture();
      },
      child: Obx(() {
        String profilePicUrl =
            profilController.userProfile.value!['profilePicUrl'] ?? '';
        if (profilePicUrl.isEmpty) {
          // Show the Container if profile picture URL is empty
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(borderRaduis)),
            ),
            child: Center(
              child: Text(
                profilController.userProfile.value!['fullName'][0]
                    .replaceAll(RegExp(r"\s+\b|\b\s"), ""),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return ClipOval(
            child: Image.network(
              profilePicUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          );
        }
      }),
    );
  }
}
