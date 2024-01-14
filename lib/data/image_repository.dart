import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class ImageRepository {
  ImageRepository(
    this._storage,
  );
  final FirebaseStorage _storage;
  Future<List<String>?> uploadImages(List<File>? images, String userId) async {
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
  }
}
