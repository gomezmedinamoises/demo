import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository {
  late LocationPermission permission;

  Future<Position> getCurrentLocation(BuildContext context) async {
    await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String?> getAddressFromCoordinates(Position? currentLocation) async {
    try {
      var currentAddress = '';
      if (currentLocation != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude,
          currentLocation.longitude,
        );

        Placemark place = placemarks[0];
        currentAddress =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}.';
      }

      return currentAddress;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
