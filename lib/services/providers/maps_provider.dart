import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ngantor/services/geo/geo_service.dart';

class MapsProvider with ChangeNotifier {
  bool _isLoading = true;
  String _currentAddress = "Unknown";
  String _currentLatLong = "Unknown";
  double _currentLat = 0;
  double _currentLong = 0;

  bool get isLoading => _isLoading;
  String get currentAddress => _currentAddress;
  String get currentLatLong => _currentLatLong;
  double get currentLat => _currentLat;
  double get currentLong => _currentLong;

  Future<void> fetchLocation() async {
    _isLoading = true;
    notifyListeners();
    try {
      LatLng userLocation = await GeoService().determineUserLocation();
      await _getAddressFromLatLng(userLocation);
      notifyListeners();

      _isLoading = false;
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}, ${place.country}, ${place.isoCountryCode}";
        _currentLatLong = "${position.latitude}, ${position.longitude}";
        _currentLat = position.latitude;
        _currentLong = position.longitude;
        print(_currentLatLong);

        notifyListeners();
      }
    } catch (e) {
      print("Error reverse geocoding: $e");
    }
  }
}