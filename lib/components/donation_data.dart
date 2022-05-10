import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:neamah/components/donation.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

/*

donation provider

notice in every method, first we edit the donation provider list,
then we edit 'Donations' in fire base

you want to read or write something related to donations?
you should use one of the methods here

 */

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
  late var time;
  late String donationClaimer;
  late String claimerPhone;

  void add_Donation(
      _imageFile,
      address,
      foodOrCloths,
      donationStatus,
      dropdownValue,
      discreption,
      id,
      email,
      time,
      donationClaimer,
      claimerPhone) async {
    donations.add(Donation(
        _imageFile,
        address,
        foodOrCloths,
        donationStatus,
        dropdownValue,
        discreption,
        id,
        email,
        time,
        donationClaimer,
        claimerPhone));
    await Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
    print('adding to provider');
  }

  void delete_Donation(Donation don) async {
    _firestore.collection('donations').doc('${don.id}').delete();
    donations.remove(don);
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  void updateStatus(Donation d, String new_status) {
    _firestore
        .collection('donations')
        .doc('${d.id}')
        .update({'donation_status': new_status});

    donations[donations.indexWhere((don) => don.id == d.id)].donationStatus =
        new_status;
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  void setDonationClaimer(Donation d, String claimer) {
    _firestore
        .collection('donations')
        .doc('${d.id}')
        .update({'donation_claimer': claimer});

    donations[donations.indexWhere((don) => don.id == d.id)].donationClaimer =
        claimer;
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  void setDonationClaimerPhone(Donation d, String phone) {
    _firestore
        .collection('donations')
        .doc('${d.id}')
        .update({'claimer_phone': phone});

    donations[donations.indexWhere((don) => don.id == d.id)].claimerPhone =
        phone;
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }
}
