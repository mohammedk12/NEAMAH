import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:neamah/components/GoogleMap.dart';
import 'package:neamah/components/setLocationButton.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:neamah/screens/Donner_screen.dart';
import 'package:neamah/screens/PIN_screen.dart';

class log_in_screen extends StatefulWidget {
  @override
  _log_in_screenState createState() => _log_in_screenState();
}

class _log_in_screenState extends State<log_in_screen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool? Donner = false;
  bool? PersonInNeed = false;
  // Completer<GoogleMapController> _controller = Completer();

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
                    (Donner == false && PersonInNeed == false)) {
                  alert(context,
                      title: Text('error'),
                      content: Text('some data is missing'));
                } else {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
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
              child: Text('Log in'),
            )
          ],
        ),
      ),
    );
  }
}

/*

showModalBottomSheet(
                  isScrollControlled:
                      true, // so that keyboard won't cover add button on the sheet
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('GoogleMapHere'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Set location'),
                        ),
                      ],
                    ),
                  ),
                );

 */
