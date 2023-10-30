import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  late String userId;
  late String action;
  late Timestamp timestamp;

  HistoryModel({
    required this.userId,
    required this.action,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'action': action,
      'timestamp': timestamp,
    };
  }

  // Factory constructor to create a HistoryModel object from a Firestore document snapshot
  factory HistoryModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HistoryModel(
      userId: data['userId'] ?? '',
      action: data['action'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
