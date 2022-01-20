import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neamah/screens/login_screen.dart';

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
                name = val;
              },
              decoration: InputDecoration(hintText: 'name'),
            ),
            TextField(
              onChanged: (val) {
                email = val;
              },
              decoration: InputDecoration(hintText: 'email'),
            ),
            TextField(
              onChanged: (val) {
                password = val;
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration:
                  InputDecoration(hintText: 'password(more then 6 charecters)'),
            ),
            TextField(
              onChanged: (val) {
                retypedPassword = val;
              },
              obscureText: true,
              decoration: InputDecoration(hintText: 'retype password'),
            ),
            TextField(
              onChanged: (val) {
                id = val;
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
                  showOkAlertDialog(
                    context: context,
                    title: 'error',
                    message: 'some data is missing',
                  );
                } else if (password != retypedPassword) {
                  showOkAlertDialog(
                    context: context,
                    title: 'error',
                    message: 'retypedPassword dose\'nt match password',
                  );
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
                      'claimed_don': '',
                      'email': email,
                    });

                    if (newUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return log_in_screen();
                        }),
                      );
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
