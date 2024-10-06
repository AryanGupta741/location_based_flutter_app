// main.dart
import 'package:flutter/material.dart';
import 'package:map_feature/providers/location_provider.dart';
import 'package:map_feature/viewmodel/location_viewmodel.dart';
import 'package:provider/provider.dart';
// import 'providers/location_provider.dart';
// import 'viewmodels/location_view_model.dart';
import 'views/location_input_screen.dart';
import 'views/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => LocationViewModel(Provider.of<LocationProvider>(context, listen: false))),
      ],
      child: MaterialApp(
        title: 'Location-based App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LocationInputScreen(),
          '/map': (context) {
            final String location = ModalRoute.of(context)!.settings.arguments as String;
            return MapScreen(location: location);
          },
        },
      ),
    );
  }
}
