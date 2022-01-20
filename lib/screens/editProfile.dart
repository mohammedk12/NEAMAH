import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neamah/screens/report_issue.dart';
import 'package:neamah/components/user_data.dart';
import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String new_password = '';
  String new_retypedPassword = '';
  String id = '';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('your current id is: $id '),
        Text('current email is ${user_data.getCurrentUserEmail()}'),
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
        ElevatedButton(
          onPressed: () {
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
                  message: 'password has to be the same as retyped password');
            } else {
              if (activeUser != null) {
                activeUser!.updatePassword(new_password);

                showOkAlertDialog(
                    context: context,
                    title: 'success',
                    message: 'password has been updated successfully');
                Navigator.pop(context);
              } else {
                print('user object is null');
              }
            }
          },
          child: Text('Update profile info '),
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return report_issue(
                    'this report is not related to a specific donation');
              }),
            );
          },
          child: Text('report an issue?'),
        )
      ],
    );
  }
}
