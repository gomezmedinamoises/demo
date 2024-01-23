import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/data/geolocation_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/image_picker_notifier.dart';
import '../data/image_repository.dart';
import '../data/report_repository.dart';

final authProvidersProvider = Provider<List<ui_auth.AuthProvider>>((ref) {
  return [ui_auth.EmailAuthProvider()];
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  return ReportRepository(
    FirebaseFirestore.instance,
  );
});

final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepository(FirebaseStorage.instance);
});

final imagePickerProvider =
    StateNotifierProvider<ImagePickerNotifier, List<File>>((ref) {
  return ImagePickerNotifier();
});

final geolocationProvider = Provider<GeolocationRepository>((ref) {
  return GeolocationRepository();
});
