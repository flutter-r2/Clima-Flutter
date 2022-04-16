import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double lon;

  Future<void> fetchLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return Future.error('Location permissions are denied');
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      );

      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      lat = 8.1322243;
      lon = -34.8967371;
    }
  }
}
