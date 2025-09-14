import 'package:geolocator/geolocator.dart';

class LocationController {
 /// Check location service and permission, then return Position
  Future<Position> getCurrentLocation() async {
    // 1️⃣ Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Ask user to turn on location
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled. Please enable them.');
    }

    // 2️⃣ Check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permission permanently denied, open app settings
      return Future.error(
          'Location permission permanently denied. Please enable from settings.');
    }

    // 3️⃣ Permissions granted & service enabled → fetch location
    return await Geolocator.getCurrentPosition(
  
    );
  }

}
