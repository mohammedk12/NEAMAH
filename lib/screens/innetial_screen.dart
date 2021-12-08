import 'package:flutter/material.dart';
import 'package:neamah/screens/login_screen.dart';
import 'package:neamah/screens/regestration_screen.dart';

// logIn/Regestration screen
class innetial_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return log_in_screen();
                    }),
                  );
                },
                child: Text('log in'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Regestration_screen();
                    }),
                  );
                },
                child: Text('register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
