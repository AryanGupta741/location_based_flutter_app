// views/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_feature/providers/location_provider.dart';
import 'package:provider/provider.dart';
// import '../providers/location_provider.dart';

class MapScreen extends StatefulWidget {
  final String location;

  const MapScreen({Key? key, required this.location}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _mapType = 'Normal'; // Default map type

  String getMapUrl(bool isDarkMode) {
    if (isDarkMode) {
      return 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'; // Dark map
    } else {
      switch (_mapType) {
        case 'Satellite':
          return 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png'; // Terrain map
        case 'Normal':
        default:
          return 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'; // Normal OSM map
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng = Provider.of<LocationProvider>(context).currentLatLng;
    bool isDarkMode = Provider.of<LocationProvider>(context).isDarkMode;

    return FutureBuilder<List<Location>>(
      future: widget.location.isNotEmpty
          ? locationFromAddress(widget.location)
          : Future.value([Location(latitude: currentLatLng.latitude, longitude: currentLatLng.longitude, timestamp: DateTime.now())]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Invalid location'));
        } else {
          LatLng loc = LatLng(snapshot.data![0].latitude, snapshot.data![0].longitude);

          return Scaffold(
            appBar: AppBar(
              title: Text('Map View'),
              actions: [
                DropdownButton<String>(
                  value: _mapType,
                  onChanged: (String? newType) {
                    setState(() {
                      _mapType = newType!;
                    });
                  },
                  items: <String>['Normal', 'Satellite']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    Provider.of<LocationProvider>(context, listen: false).toggleThemeMode();
                  },
                ),
              ],
            ),
            body: FlutterMap(
              options: MapOptions(
                center: loc,
                zoom: 13.0,
              ),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate: getMapUrl(isDarkMode),
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: loc,
                      builder: (ctx) => Container(
                        child: Icon(Icons.location_pin, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
