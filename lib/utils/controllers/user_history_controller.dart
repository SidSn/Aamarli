// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late Rx<List<DocumentSnapshot<Map<String, dynamic>>>> userHistory;

  @override
  void onInit() {
    super.onInit();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    userHistory = Rx<List<DocumentSnapshot<Map<String, dynamic>>>>([]);

    // Listen to the stream and update the userHistory list whenever there's a change
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('history')
        .snapshots()
        .listen((querySnapshot) {
      userHistory.value = querySnapshot.docs;
    });
  }
}
