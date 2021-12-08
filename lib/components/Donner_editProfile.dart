import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neamah/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:neamah/components/Donner_addDonation.dart';
import 'package:neamah/components/Location.dart';
import 'package:neamah/components/setLocationButton.dart';
import 'package:neamah/components/GoogleMap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _auth = FirebaseAuth.instance;
  User? activeUser;
  late String currentId = ''; // should be broght from database
  late String currentEmail = ''; // should be broght from database

  String new_password = '';
  String new_retypedPassword = '';

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        print('here');
        var data = await _firestore
            .collection('users')
            .doc('${activeUser!.uid}')
            .get();
        print('here2');
        setState(() {
          currentId = data.data()!['id'];
          currentEmail = activeUser!.email.toString();
        });
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('your current id is $currentId'),
        Text('current email is $currentEmail'),
        SizedBox(
          height: 25,
        ),
        TextField(
          onChanged: (val) {
            setState(() {
              new_password = val;
            });
          },
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              hintText: 'type new password(more then 6 charecters)'),
        ),
        TextField(
          onChanged: (val) {
            setState(() {
              new_retypedPassword = val;
            });
          },
          obscureText: true,
          decoration: InputDecoration(hintText: 'retype new password'),
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            //   try {
            //     final newUser = await _auth.createUserWithEmailAndPassword(
            //         email: email, password: password);
            //
            //     if (newUser != null) {
            //       if (Donner == true) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) {
            //             return Donner_view_donations_screen();
            //           }),
            //         );
            //       } else {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) {
            //             return PIN_screen();
            //           }),
            //         );
            //       }
            //     }
            //   } catch (e) {
            //     print(e);
            //   }

            if (new_password.length <= 5) {
              alert(context,
                  title: Text('error'),
                  content: Text('password cant be less then 6 chrecters'));
            } else if (new_password != new_retypedPassword) {
              alert(context,
                  title: Text('error'),
                  content:
                      Text('password has to be the same as retyped password'));
            } else {
              if (activeUser != null) {
                activeUser!.updatePassword(new_password);
                alert(context,
                    title: Text('success'),
                    content: Text('password has been updated successfully'));
              } else {
                print('user object is null');
              }
            }
          },
          child: Text('Update profile info '),
        ),
      ],
    );
  }
}
