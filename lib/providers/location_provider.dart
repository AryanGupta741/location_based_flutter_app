// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';

// class LocationProvider with ChangeNotifier {
//   String _location = '';
//   LatLng _currentLatLng = LatLng(0, 0);
//   bool _isDarkMode = false;

//   String get location => _location;
//   LatLng get currentLatLng => _currentLatLng;
//   bool get isDarkMode => _isDarkMode;

//   void setLocation(String location) {
//     _location = location;
//     notifyListeners();
//   }

//   void setCurrentLocation(double latitude, double longitude) {
//     _currentLatLng = LatLng(latitude, longitude);
//     _location = ''; // Reset inputted location when current location is used
//     notifyListeners();
//   }

//   void toggleThemeMode() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }



// providers/location_provider.dart
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  String _location = '';
  LatLng _currentLatLng = LatLng(0, 0);
  bool _isDarkMode = false;

  String get location => _location;
  LatLng get currentLatLng => _currentLatLng;
  bool get isDarkMode => _isDarkMode;

  void setLocation(String location) {
    _location = location;
    notifyListeners();
  }

  void setCurrentLocation(double latitude, double longitude) {
    _currentLatLng = LatLng(latitude, longitude);
    _location = ''; // Reset inputted location when current location is used
    notifyListeners();
  }

  void toggleThemeMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

