import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_feature/providers/location_provider.dart';
import 'package:provider/provider.dart';

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

    // Set appropriate text and icon colors for dark/light mode
    Color appBarTextColor = isDarkMode ? Colors.white : Colors.black;
    Color appBarIconColor = isDarkMode ? Colors.white : Colors.black;

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
              title: Text(
                'Map View',
                style: TextStyle(color: appBarTextColor), // Dynamic color
              ),
              backgroundColor: isDarkMode ? Colors.black87 : Colors.lightBlueAccent,
              iconTheme: IconThemeData(color: appBarIconColor), // Dynamic color for the back arrow
              actions: [
                IconButton(
                  icon: Icon(Icons.layers, color: appBarIconColor), // Dynamic icon color
                  onPressed: () {
                    _showMapTypeSelector(context);
                  },
                ),
                Switch(
                  value: isDarkMode,
                  activeColor: Colors.lightBlueAccent,
                  onChanged: (value) {
                    Provider.of<LocationProvider>(context, listen: false).toggleThemeMode();
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                FlutterMap(
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
                          width: 100.0,
                          height: 100.0,
                          point: loc,
                          builder: (ctx) => Container(
                            child: Column(
                              children: [
                                Icon(Icons.location_pin, color: Colors.red, size: 40),
                                // Optional label or tooltip for the marker
                                Text('You are here',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode ? Colors.white : Colors.black, // Adjust marker label color
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Floating button to switch map type
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      _showMapTypeSelector(context);
                    },
                    backgroundColor: Colors.lightBlueAccent,
                    child: Icon(Icons.layers_outlined),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Show a bottom sheet to select map type
  void _showMapTypeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Map Type',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                ListTile(
                  leading: Icon(Icons.map, color: Colors.lightBlueAccent),
                  title: Text('Normal Map'),
                  onTap: () {
                    setState(() {
                      _mapType = 'Normal';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.satellite, color: Colors.lightBlueAccent),
                  title: Text('Satellite Map'),
                  onTap: () {
                    setState(() {
                      _mapType = 'Satellite';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
