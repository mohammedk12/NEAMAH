import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:neamah/screens/Donner_screen.dart';
import 'package:neamah/screens/PIN_screen.dart';
import 'package:neamah/components/user_data.dart';
import 'package:neamah/components/Location.dart';
import 'package:neamah/screens/regestration_screen.dart';

class log_in_screen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  final messageTextController1 = TextEditingController();
  final messageTextController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF004086),
      //Colors.blue[800],
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/donation.png'),
                  width: 150.0,
                  height: 150.0,
                ),
                SizedBox(height: 15),
                TextField(
                    controller: messageTextController1,
                    onChanged: (val) {
                      email = val;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 10),
                TextField(
                  controller: messageTextController2,
                  onChanged: (val) {
                    password = val;
                  },
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      color: Color(0xFF007AFF),
                      //Colors.lightBlue[400],

                      onPressed: () async {
                        if (email == '' || password == '') {
                          showOkAlertDialog(
                            context: context,
                            title: 'error',
                            message: 'some data is missing',
                          );
                        } else {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            final type = await user_data.getCurrentUserType();

                            if (user != null) {
                              // user_data.getCurrentUserType() == 1
                              if (type == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Donner_view_donations_screen();
                                  }),
                                );
                              } else {
                                var loc = await Location.getLocation();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return PIN_screen(loc);
                                  }),
                                );
                              }
                              messageTextController1.clear();
                              messageTextController2.clear();
                            }
                          } catch (e) {
                            print(e);
                            showOkAlertDialog(
                              context: context,
                              title: 'error',
                              message: 'data is not correct',
                            );
                          }
                        }
                      },
                      child: Text('SIGN IN',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text(
                      'Does not have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Regestration_screen();
                          }),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
