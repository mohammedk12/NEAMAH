import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*

grab user location(lat and long)

 */
class Location {
  // static late LatLng loc;

  static Future getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      //  loc = LatLng(position.latitude, position.longitude);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }
}
