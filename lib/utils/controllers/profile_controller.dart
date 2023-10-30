// ignore_for_file: empty_catches

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<Map<String, dynamic>?> user = Rx<Map<String, dynamic>?>(null);
  Rx<Map<String, dynamic>?> userProfile = Rx<Map<String, dynamic>?>(null);
  final Rx<String?> userProfilePicUrl = Rx<String?>(null);
  @override
  void onInit() {
    super.onInit();
    // Fetch user info when the controller is initialized

    fetchUserInfo(); // Replace "USER_ID_HERE" with the actual user ID
  }

  Future<void> fetchUserInfo() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          userProfile.value = userData;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user information: $e');
    }
  }

  Future<void> addPhone(
    String phone,
  ) async {
    try {
      // Get current user ID
      String? userId = _auth.currentUser?.uid;

      if (userId != null) {
        // Update user data in Firestore
        await _firestore.collection('users').doc(userId).update({
          'phone': phone,
        });
        fetchUserInfo();

        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.snackbar('Error', 'User not signed in.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  Future<void> genderSelect(
    String gender,
  ) async {
    try {
      // Get current user ID
      String? userId = _auth.currentUser?.uid;

      if (userId != null) {
        // Update user data in Firestore
        await _firestore.collection('users').doc(userId).update({
          'gender': gender,
        });
        fetchUserInfo();

        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.snackbar('Error', 'User not signed in.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  Future<void> deleteUserInfoFromFirestore() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      String userId = user.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      // User information deleted successfully
    } catch (e) {}
  }

  Future<void> updateUserProfile(
    String fullName,
  ) async {
    try {
      String? userId = _auth.currentUser?.uid;

      if (userId != null) {
        await _firestore.collection('users').doc(userId).update({
          'fullName': fullName,
        });
        fetchUserInfo();

        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.snackbar('Error', 'User not signed in.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  var selectedGender = '-'.obs;

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> uploadProfilePicture() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File profilePicture = File(pickedFile.path);

        String storagePath = 'profile_pics/${_auth.currentUser?.uid}.jpg';
        UploadTask uploadTask =
            FirebaseStorage.instance.ref(storagePath).putFile(profilePicture);
        TaskSnapshot taskSnapshot = await uploadTask;

        String profilePicUrl = await taskSnapshot.ref.getDownloadURL();

        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .update({
          'profilePicUrl': profilePicUrl,
        });

        userProfilePicUrl.value = profilePicUrl;
        fetchUserInfo();
        Get.snackbar('Success', 'Profile picture uploaded successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload profile picture: $e');
    }
    // Similar implementation as before
  }

  Future<void> deleteProfilePictureFromStorage() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      String userId = user.uid;
      String storagePath = 'profile_pics/$userId.jpg';
      await FirebaseStorage.instance.ref(storagePath).delete();
      // Profile picture deleted successfully from Firebase Storage
    } catch (e) {
      // Handle error, for example, show a snackbar with the error message
    }
  }

  Future<void> addHistoryRecord(String action) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the reference to the user's document
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Format the timestamp
        String formattedTimestamp =
            DateFormat('dd MMM yyyy HH:mm').format(DateTime.now());

        // Add a history record to the 'history' subcollection within the user's document
        await userDocRef.collection('history').add({
          'action': action,

          'formattedTimestamp':
              formattedTimestamp, // Add formatted timestamp to Firestore
        });
      } else {}
    } catch (e) {}
  }

  Future<void> deleteHistoryItem(String documentId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('history')
            .doc(documentId)
            .delete();
      }
    } catch (e) {}
  }

  Future<void> deleteAllHistory() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the reference to the user's document
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Delete all history records in the 'history' subcollection within the user's document
        QuerySnapshot historySnapshot =
            await userDocRef.collection('history').get();
        for (QueryDocumentSnapshot doc in historySnapshot.docs) {
          await doc.reference.delete();
        }
      } else {}
    } catch (e) {}
  }
}
