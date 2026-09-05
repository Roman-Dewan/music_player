import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class LocationService {
  static Future<LocationModel?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If disabled, open the location settings from the phone setting
      await Geolocator.openLocationSettings();
      return Future.error(
        'Location services are disabled. Please enable them in settings.',
      );
    }

    // 2. Check the location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Ask for permission
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // If denied again, we can try to ask once more or return an error
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // If denied forever, open app settings so the user can grant permission manually
      await Geolocator.openAppSettings();
      return Future.error(
        'Location permissions are permanently denied. Please enable them in App Settings.',
      );
    }

    // 3. Get lat long
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
    } catch (e) {
      // Catches TimeoutException or any other errors while fetching position
      return Future.error('Failed to get current location: $e');
    }

    // 4. Format address: [thoroughfare (road), name (building/place), subLocality (area), locality postalCode (city & zip)]
    String address = '';
    try {
      List<Placemark> placemarks = await Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        List<String> addressParts = [];

        // 1. Road / Street
        String? road =
            (place.thoroughfare != null && place.thoroughfare!.trim().isNotEmpty)
            ? place.thoroughfare!.trim()
            : null;

        // Fallback for road if thoroughfare is empty
        if (road == null && place.street != null && place.street!.trim().isNotEmpty) {
          if (!place.street!.contains(',')) {
            road = place.street!.trim();
          }
        }

        if (road != null && road.isNotEmpty) {
          addressParts.add(road);
        }

        // 2. Building / Place / House Name
        if (place.name != null && place.name!.trim().isNotEmpty) {
          final name = place.name!.trim();
          if (!addressParts.contains(name) && name != road && name != place.postalCode && name != place.subLocality && name != place.locality) {
            addressParts.add(name);
          }
        }

        // 3. Area / Sub-locality
        if (place.subLocality != null && place.subLocality!.trim().isNotEmpty) {
          final subLocality = place.subLocality!.trim();
          if (!addressParts.contains(subLocality)) {
            addressParts.add(subLocality);
          }
        }

        // 4. City + Postal Code (e.g. "Dhaka 1207")
        String? city = (place.locality != null && place.locality!.trim().isNotEmpty)
                          ? place.locality!.trim()
                          : (place.subAdministrativeArea != null && place.subAdministrativeArea!.trim().isNotEmpty)
                              ? place.subAdministrativeArea!.trim()
                              : null;

        String? postal = (place.postalCode != null && place.postalCode!.trim().isNotEmpty)
                          ? place.postalCode!.trim()
                          : null;

        String cityPostal = [city, postal].where((e) => e != null && e.isNotEmpty).join(' ');

        if (cityPostal.isNotEmpty && !addressParts.contains(cityPostal)) {
          addressParts.add(cityPostal);
        }

        // Fallback if none of the specific parts were resolved
        if (addressParts.isEmpty && place.street != null && place.street!.trim().isNotEmpty) {
          address = place.street!.trim();
        } else {
          address = addressParts.join(', ');
        }
      }
    } catch (e) {
      address = 'Address not found';
      if (kDebugMode) log(e.toString());
    }

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  }
}
