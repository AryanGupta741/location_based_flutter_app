import 'package:flutter/material.dart';
import 'package:map_feature/viewmodel/location_viewmodel.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationViewModel = Provider.of<LocationViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.tealAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Light-themed frosted glass effect with minimal shadow
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Enter Location',
                              style: TextStyle(
                                fontSize: 26.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            // Clean, minimalistic text field
                            TextField(
                              controller: locationViewModel.locationController,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                labelText: 'City name, address, or coordinates',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.my_location, color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Use Current Location',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: locationViewModel.useCurrentLocation,
                                  activeColor: Colors.lightBlue.shade300,
                                  inactiveThumbColor: Colors.grey.shade400,
                                  inactiveTrackColor: Colors.grey.shade200,
                                  onChanged: (value) async {
                                    locationViewModel.toggleUseCurrentLocation(value);
                                    if (locationViewModel.useCurrentLocation) {
                                      await locationViewModel.getCurrentLocation();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                // Subtle gradient button with light color tones
                GestureDetector(
                  onTapDown: (_) {
                    _animationController.forward();
                  },
                  onTapUp: (_) {
                    _animationController.reverse();
                    if (locationViewModel.locationController.text.isNotEmpty ||
                        locationViewModel.useCurrentLocation) {
                      Navigator.pushNamed(
                        context,
                        '/map',
                        arguments: locationViewModel.locationController.text,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a location or use current location')),
                      );
                    }
                  },
                  child: ScaleTransition(
                    scale: Tween(begin: 1.0, end: 0.95).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeOut,
                    )),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlue.shade300, Colors.tealAccent.shade100],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Show on Map',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
