import 'package:cloud_firestore/cloud_firestore.dart';

class ReportRepository {
  ReportRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> createReport(
    String id,
    String userId,
    String title,
    String description,
    String createdAt,
  ) =>
      _firestore.collection('users/$userId/reports').add(
        {
          'id': id,
          'title': title,
          'description': description,
          'createdAt': createdAt,
        },
      );
}
