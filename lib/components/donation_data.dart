import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:neamah/components/donation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// provider object
class donation_data extends ChangeNotifier {
  List<Donation> donations = [];

  late GeoPoint address;
  late String discreption;
  late String donationStatus;
  late int dropdownValue;
  late String email;
  late String foodOrCloths;
  late String id;
  late String imageFile;

  void add_Donation(_imageFile, address, foodOrCloths, donationStatus,
      dropdownValue, discreption, id, email) {
    donations.add(Donation(_imageFile, address, foodOrCloths, donationStatus,
        dropdownValue, discreption, id, email));
    notifyListeners();
    print('adding to provider');
  }

  void delete_Donation(Donation d) {
    donations.remove(d);
    notifyListeners();
  }
}
//   void updateTask(Task task) {
//     task.toggleDone();
//     notifyListeners();
//   }
//
//   void deleteTask(Task task) {
//     tasks.remove(task);
//     notifyListeners();
//   }
// }
