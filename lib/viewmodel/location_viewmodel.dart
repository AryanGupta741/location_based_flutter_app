// viewmodels/location_view_model.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_feature/providers/location_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import '../models/location_model.dart';
// import '../providers/location_provider.dart';

class LocationViewModel with ChangeNotifier {
  final LocationProvider _locationProvider;

  LocationViewModel(this._locationProvider);

  TextEditingController locationController = TextEditingController();
  bool useCurrentLocation = false;

  Future<void> getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.request();

    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _locationProvider.setCurrentLocation(position.latitude, position.longitude);
      locationController.text = '${position.latitude}, ${position.longitude}';
      notifyListeners();
    } else {
      throw Exception('Location permission denied.');
    }
  }

  void toggleUseCurrentLocation(bool value) {
    useCurrentLocation = value;
    notifyListeners();
  }

  void updateLocation(String location) {
    _locationProvider.setLocation(location);
    notifyListeners();
  }
}
