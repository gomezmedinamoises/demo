import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePickerNotifier extends StateNotifier<List<File>> {
  ImagePickerNotifier() : super([]);

  Future pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      state = [...state, File(image.path)];
    }
  }

  void removeImage(File image) {
    state = state.where((element) => element != image).toList();
  }

  void clearImages() {
    state = [];
  }
}
