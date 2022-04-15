import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double lon;

  Future<void> currentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return Future.error('Location permissions are denied');
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      print(e);
    }

    print(lat);
    print(lon);
  }
}
