import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neamah/components/setLocationButton.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:neamah/screens/Donner_screen.dart';
import 'package:neamah/screens/PIN_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class Regestration_screen extends StatefulWidget {
  @override
  _Regestration_screenState createState() => _Regestration_screenState();
}

class _Regestration_screenState extends State<Regestration_screen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String retypedPassword = '';
  String id = '';
  bool? Donner = false;
  bool? PersonInNeed = false;
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
              decoration: InputDecoration(hintText: 'name'),
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
              decoration: InputDecoration(hintText: 'email'),
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration:
                  InputDecoration(hintText: 'password(more then 6 charecters)'),
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  retypedPassword = val;
                });
              },
              obscureText: true,
              decoration: InputDecoration(hintText: 'retype password'),
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  id = val;
                });
              },
              decoration: InputDecoration(hintText: 'ID'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I am a donner'),
                Checkbox(
                    value: Donner,
                    onChanged: (bool) {
                      setState(() {
                        Donner = bool;
                        PersonInNeed = false;
                      });
                    }),
                Text('I am a person in need'),
                Checkbox(
                    value: PersonInNeed,
                    onChanged: (bool) {
                      setState(() {
                        PersonInNeed = bool;
                        Donner = false;
                      });
                    }),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (email == '' ||
                    password == '' ||
                    retypedPassword == '' ||
                    id == '' ||
                    (Donner == false && PersonInNeed == false)) {
                  alert(context,
                      title: Text('error'),
                      content: Text('some data is missing'));
                } else if (password != retypedPassword) {
                  alert(context,
                      title: Text('error'),
                      content: Text('retypedPassword dose\'nt match password'));
                } else {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                    _firestore
                        .collection('users')
                        .doc('${newUser.user!.uid}')
                        .set({
                      'DonnerOrPIN': Donner == true ? 1 : 2,
                      'id': id,
                      'name': name,
                    });

                    if (newUser != null) {
                      if (Donner == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Donner_view_donations_screen();
                          }),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PIN_screen();
                          }),
                        );
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
