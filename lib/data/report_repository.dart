import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/report.dart';

class ReportRepository {
  ReportRepository(
    this._firestore,
  );
  final FirebaseFirestore _firestore;

  /*Future<void> createReport(Report report) async {
    final imageUrls = await _uploadImages(report.imageUrls, report.userId);
    await _firestore.collection('users/${report.userId}/reports').add(
      {
        'id': report.id,
        'userId': report.userId,
        'title': report.title,
        'description': report.description,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'Abierto',
        'imageUrls': imageUrls,
      },
    );
  }*/

  Future<void> createReport(String id, String userId, String title,
          String description, List<String>? imageUrls) =>
      _firestore.collection('users/$userId/reports').add(
        {
          'id': id,
          'userId': userId,
          'title': title,
          'description': description,
          'createdAt': FieldValue.serverTimestamp(),
          'status': 'Abierto',
          'imageUrls': imageUrls,
        },
      );

  Query<Report> reportsQuery(String userId) {
    return _firestore
        .collection('users/$userId/reports')
        .withConverter(
          fromFirestore: (snapshot, _) => Report.fromMap(snapshot.data()),
          toFirestore: (report, _) => report.toMap(),
        )
        .orderBy('createdAt', descending: true);
  }

  /*Future<List<String>?> _uploadImages(List<File>? images, String userId) async {
    final storageRef = _storage.ref();
    List<String>? uploadedImageUrls = [];

    if (images != null) {
      for (var image in images) {
        String fileName = path.basename(image.path);
        var fileRef = storageRef.child('reports/$userId/$fileName');
        await fileRef.putFile(image);
        String downloadUrl = await fileRef.getDownloadURL();
        uploadedImageUrls.add(downloadUrl);
      }
    }

    return uploadedImageUrls;
  }*/
}
