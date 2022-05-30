import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:neamah/components/setLocationButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:neamah/components/user_data.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

final _firestore = FirebaseFirestore.instance;

String donationStatus = 'Not Claimed';
String donationClaimer = 'no claimer yet';
String claimerPhone = '';

class addDonation extends StatefulWidget {
  @override
  _addDonationState createState() => _addDonationState();
}

class _addDonationState extends State<addDonation> {
  bool? food = false;
  bool? cloths = false;
  String discreption = '';
  PickedFile? _imageFile;
  int dropdownValue = 1;
  late LatLng address;
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/neamah-7e68e.appspot.com/o/images%2Fdownload.png?alt=media&token=c9fb9bfb-0ba0-45d2-bf57-f2bd69882901';
  ImagePicker _picker = ImagePicker();

  Widget myImage() {
    return Column(children: [
      InkWell(
        child: Container(
           height: 150.0,
           width: 150,
          //height: 100.0,
          //width: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: _imageFile == null
                  ? NetworkImage(imageUrl) as ImageProvider
                  : FileImage(File(_imageFile!.path)),
              fit: BoxFit.fill,
            ),
          ),
        ),
        onTap: () {
          takePhoto(ImageSource.camera);
        },
      ),
      // FlatButton.icon(
      //   icon: Icon(Icons.image),
      //   onPressed: () {
      //     takePhoto(ImageSource.gallery);
      //   },
      //   label: Text("Gallery"),
      // ),
    ]);
  }

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });

    if (_imageFile != null) {
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';

      final taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child('images/$imageName')
          .putFile(File(_imageFile!.path));
      setState(() async {
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      });
    } else {
      print('No Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        myImage(),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Donation Type:   ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              Text('Food'),
              Checkbox(
                  value: food, //
                  onChanged: (bool) {
                    setState(() {
                      food = bool;
                      cloths = false;
                    });
                  }),
              Text('Cloths'),
              Checkbox(
                  value: cloths,
                  onChanged: (bool) {
                    setState(() {
                      cloths = bool;
                      food = false;
                    });
                  }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Description:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextField(
            onChanged: (val) {
              discreption = val;
            },
            decoration:
                InputDecoration(hintText: ' (Ex. rice and chicken, 2 shirts)'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // myImage(),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Quantity ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              Text('for how many people?        ',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: dropdownValue.toString(),
                icon: Icon(Icons.arrow_downward),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = int.parse(newValue!);
                  });
                },
                items: <String>['1', '2', '3', '4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        setLocationButton(),
        SizedBox(height: 10),
        Container(
          width: 200,
          height: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FlatButton(
              color: Colors.blue[800],
              onPressed: () async {
                try {
                  address = setLocationButton.address;
                  if (discreption != '' &&
                      address != null &&
                      (food == true || cloths == true)) {
                    if (address != null) {
                      try {
                        var donorPhone = await user_data.getCurrentUserPhone();
                        _firestore.collection('donations').add({
                          'address':
                              GeoPoint(address.latitude, address.longitude),
                          'discreption': discreption,
                          'donation_status': donationStatus,
                          'QuantityPerPerson': dropdownValue,
                          'email': user_data.getCurrentUserEmail(),
                          'donation_type': food == true ? 'food' : 'cloths',
                          'image': imageUrl,
                          'donation_claimer': donationClaimer,
                          'claimer_phone': claimerPhone,
                          'donor_phone': donorPhone,
                          'timestamp': FieldValue.serverTimestamp(),
                          //to save time of messge so we can display it in order
                        });
                        user_data.updateScore();
                        Navigator.pop(context);
                      } catch (e) {
                        print('bbb');
                        print(e);
                      }
                    } else {
                      print('address is null');
                    }
                  } else {
                    showOkAlertDialog(
                      context: context,
                      title: 'error',
                      message: 'some data is missing',
                    );
                  }
                } catch (e) {
                  showOkAlertDialog(
                    context: context,
                    title: 'error',
                    message: 'some data is missing',
                  );
                }
              },
              child:
                  Text('Add Donation', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
