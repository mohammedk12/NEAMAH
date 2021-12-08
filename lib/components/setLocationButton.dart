import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neamah/components/GoogleMap.dart';
import 'package:neamah/components/Location.dart';

class setLocationButton extends StatelessWidget {
  static var address;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Location
            .getLocation(); // we have to say this before using lat and long

        address = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            //  return map(Location.latitude, Location.longitude);
            return map(Location.loc);
          }),
        );
      },
      child: Text('Set up location'),
    );
  }
}
