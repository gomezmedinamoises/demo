// ignore_for_file: must_be_immutable

import 'package:demo/core/style/palette_colors.dart';
import 'package:demo/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationSection extends ConsumerWidget {
  GeoLocationSection({
    super.key,
  });

  Position? currentLocation;
  String? currentAddress = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geolocationRepository = ref.read(geolocationProvider);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Agregar localización',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0), // Aumenta el padding
                textStyle: const TextStyle(fontSize: 18.0),
              ).copyWith(alignment: Alignment.center),
              onPressed: () async {
                final currentPosition =
                    await geolocationRepository.getCurrentLocation(context);

                geolocationRepository
                    .getAddressFromCoordinates(currentPosition);
              },
              child: const Text(
                'Obtener localización',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LAT: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PaletteColors.grey007),
                        ),
                        Expanded(
                            child: Text(
                          '',
                          softWrap: true,
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LON: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PaletteColors.grey007),
                        ),
                        Expanded(
                            child: Text(
                          '',
                          softWrap: true,
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DIR: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PaletteColors.grey007),
                        ),
                        Expanded(
                          child: Text(
                            '',
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
