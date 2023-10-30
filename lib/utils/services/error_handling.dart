import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showFirebaseAuthSnackbar(dynamic error) {
  String errorMessage = 'authentication_failed'.tr; // Default error message

  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'user-not-found':
        errorMessage = 'user_not_found'.tr;
        break;
      case 'wrong-password':
        errorMessage = 'invalid-password'.tr;
        break;
      // Add more cases for other error codes if needed
    }
  }

  Get.snackbar(
    'Authentication Error',
    errorMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

void showFirebaseSignUpSnackbar(dynamic error) {
  String errorMessage = 'signup_failed'.tr; // Default error message

  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'email-already-in-use':
        errorMessage = 'email_in_use'.tr;
        break;
      case 'invalid-email':
        errorMessage = 'invalid_email'.tr;
        break;
      case 'weak-password':
        errorMessage = 'weak_password'.tr;
        break;
      // Add more cases for other error codes if needed
    }
  }

  Get.snackbar(
    'Sign-up Error',
    errorMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

void showFirebasePasswordResetSnackbar(dynamic error) {
  String errorMessage = 'password_reset_failed'.tr; // Default error message

  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'user-not-found':
        errorMessage = 'user_not_found_reset'.tr;
        break;
      case 'invalid-email':
        errorMessage = 'invalid_email'.tr;
        break;
      // Add more cases for other error codes if needed
    }
  }

  Get.snackbar(
    'Password Reset Error',
    errorMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
