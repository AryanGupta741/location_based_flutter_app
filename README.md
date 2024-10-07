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

- **Model view  view mdoel**: MVVM architecture is followed.
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

1. lib/
├── main.dart
├── models/
│   └── location_model.dart
├── providers/
│   └── location_provider.dart
├── screens/
│   ├── location_input_screen.dart
│   └── map_screen.dart
├── viewmodels/
│   └── location_viewmodel.dart
└── widgets/
    └── custom_button.dart


2. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/location-based-flutter-app.git
   cd location-based-flutter-app

### Final result
<img src="https://github.com/user-attachments/assets/d8475306-7977-4dc1-ba56-0c1b472901d0" alt="Location Input Screen" width="300" /> 
<img src="https://github.com/user-attachments/assets/d2a67682-702a-4a54-b17b-147b7f726528" alt="Map Screen" width="300" /> 
<img src="https://github.com/user-attachments/assets/923a033d-500a-4776-84fc-3b72db8faa05" alt="Map with Marker" width="300" /> 
<img src="https://github.com/user-attachments/assets/8d69a33c-9e68-4938-bb71-786322847767" alt="Another View" width="300" /> 
<img src="https://github.com/user-attachments/assets/f3300b7e-cf8b-4b0f-9ffa-edaa7d0ada20" alt="Map Type Switching" width="300" /> 
<img src="https://github.com/user-attachments/assets/18110eba-9733-4796-863f-6b2805351421" alt="Location Validation" width="300" /> 
<img src="https://github.com/user-attachments/assets/845d372d-ae56-465e-bcee-84aebaa3d1c2" alt="Marker on Map" width="300" />
 <img src="https://github.com/user-attachments/assets/236dae68-09e2-4a7b-b5f1-bcd39dd7fcc2" alt="User Input" width="300" />
 <img src="https://github.com/user-attachments/assets/53d175ef-e056-431c-91ce-77030a28a96a" alt="Different Map Type" width="300" />
