import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/report.dart';

class ReportRepository {
  ReportRepository(
    this._firestore,
  );
  final FirebaseFirestore _firestore;

  Future<void> createReport(String id, String userId, String title,
      String description, List<String>? imagesUrls) async {
    _firestore.collection('users/$userId/reports').add(
      {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'Abierto',
        'imagesUrls': imagesUrls,
      },
    );
  }

  Query<Report> reportsQuery(String userId) {
    return _firestore
        .collection('users/$userId/reports')
        .withConverter(
          fromFirestore: (snapshot, _) => Report.fromMap(snapshot.data()),
          toFirestore: (report, _) => report.toMap(),
        )
        .orderBy('createdAt', descending: true);
  }
}
