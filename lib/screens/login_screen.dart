import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:neamah/screens/Donner_screen.dart';
import 'package:neamah/screens/PIN_screen.dart';
import 'package:neamah/components/user_data.dart';
import 'package:neamah/components/Location.dart';

class log_in_screen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

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
                email = val;
              },
              decoration: InputDecoration(hintText: 'email'),
            ),
            TextField(
              onChanged: (val) {
                password = val;
              },
              obscureText: true,
              decoration: InputDecoration(hintText: 'password'),
            ),
            ElevatedButton(
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
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text('Log in'),
            )
          ],
        ),
      ),
    );
  }
}
