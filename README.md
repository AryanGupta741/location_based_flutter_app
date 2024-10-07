# Simple Location-Based Flutter App

## Overview

This simple Flutter application allows users to input a location (city name, address, or coordinates) and view it on a map. The app provides two main screens:
1. **Location Input Screen**: The user can enter a location through a text field.
2. **Map Screen**: Using a marker, the app displays the entered location on a map.

The app integrates a map using the `flutter_map` package and OpenStreetMap tiles. Basic validation, state management, and map type switching are implemented.

## Features

- **Location Input**: Users can input a city, address, or coordinates into the text field.
- **Map Display**: Displays the entered location with a marker on the map.
- **Map Type Switching**: Users can toggle between different map types (e.g., normal, satellite).
- **Current Location (Bonus)**: Users can toggle using their current location for display on the map.

## How It Works

1. On the **Location Input Screen**, users enter the desired location in the text field and click the **Show on Map** button.
2. If the input is valid (non-empty), the app will navigate to the **Map Screen**.
3. The **Map Screen** retrieves the location (either from the text input or the current location) and displays it on an interactive map.
4. A dropdown allows users to switch between different map types (e.g., Normal, Satellite, Terrain).
5. The location is shown as a marker on the map.

## App Structure

- **Main.dart**: The entry point of the app.
- **Screens**:
  - `location_input_screen.dart`: The screen for entering the location.
  - `map_screen.dart`: The screen for displaying the location on a map.
- **ViewModels**:
  - `location_viewmodel.dart`: Manages the state for location input and handles retrieving the current location.
- **Providers**:
  - `location_provider.dart`: Provides location data and manages dark mode switching.

## Packages Used

- `provider`: For state management.
- `flutter_map`: To display the map using OpenStreetMap.
- `geocoding`: To convert addresses into latitude/longitude.
- `latlong2`: To represent geographic coordinates (latitude and longitude).
- `geolocator`: (Optional) To retrieve the current location of the user.

## Installation and Setup

### Prerequisites
- Ensure that Flutter is installed on your machine. If not, follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- The app uses the `flutter_map` package, so make sure you have an internet connection to fetch map tiles.

### Steps to Run the App

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/location-based-flutter-app.git
   cd location-based-flutter-app
