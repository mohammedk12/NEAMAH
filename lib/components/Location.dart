import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
to get tha lat and long, you have to say first: await getLocation()
 */
class Location {
  // static late double latitude;
  // static late double longitude;
  static late LatLng loc;

  static Future getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      // latitude = position.latitude;
      // longitude = position.longitude;
      loc = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }
}
