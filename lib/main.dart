import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neamah/screens/innetial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:neamah/components/donation_data.dart';
import 'package:provider/provider.dart';

// change minsdkversion to at least 20

void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  //
  runApp(MaterialApp(home: MyApp()));
}

// provider > myApp > MaterialApp > innetial_screen

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          donation_data(), // returns the object that need to be provided to all of the children in the tree (which is TaskData)
      child: MaterialApp(
        home: innetial_screen(),
      ),
    );
    // return innetial_screen();
    return MaterialApp(
      home: innetial_screen(),
    );
  }
}
