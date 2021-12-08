import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Donation {
  late GeoPoint address;
  late String discreption;
  late String donationStatus;
  late int dropdownValue;
  late String email;
  late String foodOrCloths;
  late String id;
  late String imageFile;

  Donation(this.imageFile, this.address, this.foodOrCloths, this.donationStatus,
      this.dropdownValue, this.discreption, this.id, this.email);
}

/*
  'address': GeoPoint(address.latitude, address.longitude),
                  'discreption': discreption,
                  'donation_status': donationStatus,
                  'dropdownvalue': dropdownValue,
                  'email': activeUser!.email,
                  'food_or_cloths': food == true ? 'food' : 'cloths',
                  'image': _imageFile == null
                      ? 'images/download.png'
                      : _imageFile!.path,
                  'timestamp': FieldValue
                      .serverTimestamp(), //to save time of messge so we can display it in order
 */
