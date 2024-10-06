// models/location_model.dart
class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationModel({required this.latitude, required this.longitude, required this.address});

  factory LocationModel.fromCoordinates(double latitude, double longitude) {
    return LocationModel(latitude: latitude, longitude: longitude, address: '');
  }

  factory LocationModel.fromAddress(String address) {
    return LocationModel(latitude: 0.0, longitude: 0.0, address: address);
  }
}
