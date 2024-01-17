import 'package:demo/presentation/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/style/palette_colors.dart';
import '../providers.dart';

class LoadPhotosSection extends ConsumerWidget {
  const LoadPhotosSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(imagePickerProvider);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Cargar fotos',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: images.length >= 3
                      ? null
                      : () {
                          ref
                              .read(imagePickerProvider.notifier)
                              .pickImage(ImageSource.camera);
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return PaletteColors.grey005;
                        }
                        return null;
                      },
                    ),
                  ),
                  child: const Text(
                    'Cámara',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: ElevatedButton(
                  onPressed: images.length >= 3
                      ? null
                      : () {
                          ref
                              .read(imagePickerProvider.notifier)
                              .pickImage(ImageSource.gallery);
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return PaletteColors.grey005;
                        }
                        return null;
                      },
                    ),
                  ),
                  child: const Text(
                    'Galería',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: images
                  .map(
                    (file) => ImageCard(
                      file: file,
                      onRemove: () => ref
                          .read(imagePickerProvider.notifier)
                          .removeImage(file),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
