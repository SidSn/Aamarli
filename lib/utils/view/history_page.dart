// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/const/colors.dart';
import 'package:test_app/utils/controllers/user_history_controller.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';

class HistoryScreen extends StatelessWidget {
  final UserController _userController = Get.put(UserController());
  final ThemeController controller = Get.put(ThemeController());

  HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDarkMode.value ? bgColor : const Color(0xfffefffe),
      appBar: AppBar(
        title: Text(
          'history'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
              onPressed: () {
                profileController.deleteAllHistory();
              },
              icon: const Icon(Icons.delete_forever))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<DocumentSnapshot>>(
          stream: _userController.userHistory.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot> historyDocs = snapshot.data ?? [];

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: historyDocs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> historyData =
                      historyDocs[index].data() as Map<String, dynamic>;
                  String action = historyData['action'];
                  String formattedTimestamp =
                      historyData['formattedTimestamp'] ?? '';
                  String documentId = historyDocs[index].id;

                  return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: controller.isDarkMode.value
                                ? secondaryColor
                                : bgColorLight,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  offset: const Offset(1, 2),
                                  color: Colors.black.withOpacity(0.2))
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: ListTile(
                          title: Text(action),
                          subtitle:
                              Text('time'.tr + ' : ' + '$formattedTimestamp'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _showDeleteConfirmationDialog(
                                context, documentId),
                          ),
                        ),
                      ));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

final ProfileController profileController = Get.put(ProfileController());
Future<void> _showDeleteConfirmationDialog(
    BuildContext context, String documentId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('del'.tr),
        content: Text('confir'.tr),
        actions: <Widget>[
          TextButton(
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('dele'.tr),
            onPressed: () {
              profileController.deleteHistoryItem(documentId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
