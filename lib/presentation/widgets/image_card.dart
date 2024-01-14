import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/style/palette_colors.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.file,
    required this.onRemove,
  });

  final File file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              file,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                    color: PaletteColors.grey003, shape: BoxShape.circle),
                child: const Icon(
                  Icons.close,
                  color: PaletteColors.grey008,
                  size: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
