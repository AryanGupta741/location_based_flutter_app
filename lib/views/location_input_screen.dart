import 'package:flutter/material.dart';
import 'package:map_feature/viewmodel/location_viewmodel.dart';
import 'package:provider/provider.dart';
// import '../viewmodels/location_view_model.dart'; // Import the correct ViewModel

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  @override
  Widget build(BuildContext context) {
    // Using Provider to access the LocationViewModel and listen to updates
    final locationViewModel = Provider.of<LocationViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Enter Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationViewModel.locationController,
              decoration: InputDecoration(
                labelText: 'Enter location (city name, address, or coordinates)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Use Current Location'),
                Switch(
                  value: locationViewModel.useCurrentLocation,
                  onChanged: (value) async {
                    locationViewModel.toggleUseCurrentLocation(value);
                    if (locationViewModel.useCurrentLocation) {
                      await locationViewModel.getCurrentLocation();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (locationViewModel.locationController.text.isNotEmpty) {
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
              child: Text('Show on Map'),
            ),
          ],
        ),
      ),
    );
  }
}
