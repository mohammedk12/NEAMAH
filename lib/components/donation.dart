import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  late GeoPoint address;
  late String discreption;
  late String donationStatus;
  late int dropdownValue;
  late String email;
  late String foodOrCloths;
  late String id;
  late String imageFile;
  late var time;
  late String donationClaimer;

  Donation(
      this.imageFile,
      this.address,
      this.foodOrCloths,
      this.donationStatus,
      this.dropdownValue,
      this.discreption,
      this.id,
      this.email,
      this.time,
      this.donationClaimer);
}
