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
  String dropdownValue = 'choose';
  String phone = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),

                // Image(image: AssetImage('images/donation.png'),width: 150.0, height: 150.0,),
                SizedBox(height: 15),
                TextField(
                  onChanged: (val) {
                    id = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'ID',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4)),
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  onChanged: (val) {
                    name = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4)),
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4)),
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  onChanged: (val) {
                    password = val;
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password (more than 6 charecters)',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4)),
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  onChanged: (val) {
                    retypedPassword = val;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4)),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    phone = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4)),
                  ),
                ),
                SizedBox(height: 7),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Donor'),
                    Checkbox(
                        value: Donner,
                        onChanged: (bool) {
                          setState(() {
                            Donner = bool;
                            PersonInNeed = false;
                          });
                        }),
                    Text('Needy'),
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
                SizedBox(
                  height: 7,
                ),
                Container(
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      color: Color(0xFF007AFF),
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
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
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
                              'score': 0,
                              'phone': phone,
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
                      child: Text('SIGN UP',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
