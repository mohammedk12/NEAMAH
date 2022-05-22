import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neamah/components/user_data.dart';
import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  String new_password = '';
  String new_retypedPassword = '';
  String id = '';
  final bool hasNavigation = true;
  final messageTextController1 = TextEditingController();
  final messageTextController2 = TextEditingController();

  Future getId() async {
    final id = await user_data.getCurrentUserID();
    setState(() {
      this.id = id;
    });
    return id;
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004086),
        ),
        // backgroundColor: Color(0xFF004086),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              SizedBox(height: 40),
              Text(
                'Change Password',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              TextField(
                controller: messageTextController1,
                onChanged: (val) {
                  setState(() {
                    new_password = val;
                  });
                },
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    hintText: 'Password (more than 6 charecters)',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4))),
              ),
              SizedBox(height: 10),
              TextField(
                controller: messageTextController2,
                onChanged: (val) {
                  setState(() {
                    new_retypedPassword = val;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD1D0D4)),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4))),
              ),
              SizedBox(height: 60),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: Color(0xFF0E468B),
                  onPressed: () {
                    messageTextController1.clear();
                    messageTextController2.clear();
                    if (new_password.length <= 5) {
                      showOkAlertDialog(
                        context: context,
                        title: 'error',
                        message: 'password cant be less then 6 chrecters',
                      );
                    } else if (new_password != new_retypedPassword) {
                      showOkAlertDialog(
                          context: context,
                          title: 'error',
                          message:
                              'password has to be the same as retyped password');
                    } else {
                      if (activeUser != null) {
                        activeUser!.updatePassword(new_password);

                        showOkAlertDialog(
                            context: context,
                            title: 'success',
                            message: 'password has been updated successfully');
                      } else {
                        print('user object is null');
                      }
                    }
                  },
                  child: Text(
                    'Save Changes ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
