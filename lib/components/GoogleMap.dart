import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'dart:async';
import 'package:neamah/components/setLocationButton.dart';

class map extends StatelessWidget {
  late LatLng location;
  //late final double lat;
  //late final double long;
  late CameraPosition cameraPosition;

  map(LatLng loc) {
    this.location = loc;

    // this.lat =lat;
    // this.long = long;

    cameraPosition = CameraPosition(
      // target: LatLng(lat, long),
      target: location,
      zoom: 18.4746,
    );
  }

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  late GoogleMapController gmc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: Icon(
              Icons.location_on_outlined,
              size: 50,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                gmc = controller;
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
            ),
          ),
          Positioned(
            top: 50,
            right: 15,
            child: FloatingActionButton.small(
                child: Icon(Icons.my_location),
                onPressed: () {
                  gmc.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                      //target: LatLng(lat, long),
                      target: location,
                      zoom: 18.4746,
                    )),
                  );
                }),
          ),
          Positioned(
            top: 600,
            child: ElevatedButton(
              child: Text(
                'set location',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                print(
                    "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                Navigator.pop(context, cameraPosition.target);
              },
            ),
          ),
        ],
      ),
    );
  }
}
