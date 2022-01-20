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

String donationStatus = 'not claimed';
String donationClaimer = 'no claimer yet';

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
    return Column(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageFile == null
                  ? NetworkImage(imageUrl) as ImageProvider
                  : FileImage(File(_imageFile!.path)),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text('add picture: '),
          FlatButton.icon(
            icon: Icon(Icons.camera),
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),
          ),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: () {
              takePhoto(ImageSource.gallery);
            },
            label: Text("Gallery"),
          ),
        ]),
      ],
    );
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('food'),
            Checkbox(
                value: food,
                onChanged: (bool) {
                  setState(() {
                    food = bool;
                    cloths = false;
                  });
                }),
            Text('cloths'),
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
        TextField(
          onChanged: (val) {
            discreption = val;
          },
          decoration: InputDecoration(hintText: 'discreption'),
        ),
        SizedBox(
          height: 10,
        ),
        myImage(),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('qunatity for how many people?'),
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
        setLocationButton(),
        ElevatedButton(
          onPressed: () async {
            address = setLocationButton.address;

            if (discreption == '' ||
                address == null ||
                (food == false && cloths == false)) {
              showOkAlertDialog(
                context: context,
                title: 'error',
                message: 'some data is missing',
              );
            } else {
              try {
                _firestore.collection('donations').add({
                  'address': GeoPoint(address.latitude, address.longitude),
                  'discreption': discreption,
                  'donation_status': donationStatus,
                  'dropdownvalue': dropdownValue,
                  'email': user_data.getCurrentUserEmail(),
                  'food_or_cloths': food == true ? 'food' : 'cloths',
                  'image': imageUrl,
                  'donation_claimer': donationClaimer,
                  'timestamp': FieldValue
                      .serverTimestamp(), //to save time of messge so we can display it in order
                });

                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            }
          },
          child: Text('add donation'),
        ),
      ],
    );
  }
}
