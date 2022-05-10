import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neamah/screens/report_issue.dart';
import 'package:neamah/components/user_data.dart';
import 'dart:async';
import 'package:neamah/screens/donation screens/changePassword.dart';

class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String new_password = '';
  String new_retypedPassword = '';
  String id = '';
  int score = 0;
  final bool hasNavigation = true;

  Future getId() async {
    final id = await user_data.getCurrentUserID();
    setState(() {
      this.id = id;
    });
    return id;
  }

  Future getScore() async {
    final score = await user_data.getCurrentUserScore();
    setState(() {
      this.score = score;
    });
    return score;
  }

  @override
  void initState() {
    getId();
    getScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 10 * 10,
                    width: 10 * 10,
                    margin: EdgeInsets.only(top: 10 * 3),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 10 * 5,
                          child: Icon(
                            Icons.person,
                            size: 90,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10 * 2),
                  Text(
                    'id: #$id',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10 * 0.5),
                  Text(
                    'score: $score 🔥 ',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    'email: ${user_data.getCurrentUserEmail()}',
                    style: TextStyle(color: Colors.black),
                  ),

                  //   mainAxisAlignment: MainAxisAlignment.center,

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                      height: 10 * 5.5,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10 * 3,
                      ).copyWith(
                        bottom: 10 * 2,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * 3),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          //print('Hi');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return changePassword();
                            }),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.lock,
                              color: Colors.black,
                              size: 10 * 2.5,
                            ),
                            SizedBox(width: 10 * 1.5),
                            Text(
                              'Change Password ',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            Spacer(),
                            if (this.hasNavigation)
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.black,
                                size: 10 * 3.5,
                              ),
                            // Spacer()
                            //    FloatingActionButton(onPressed:(){} )
                          ],
                          //     child: RaisedButton(
                          //          onPress:
                          //     )
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                      height: 10 * 5.5,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10 * 3,
                      ).copyWith(
                        bottom: 10 * 2,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * 3),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          //print('Hi');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return report_issue(
                                  'this report is not related to a specific donation');
                            }),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.question_circle,
                              color: Colors.black,
                              size: 10 * 2.5,
                            ),
                            SizedBox(width: 10 * 1.5),
                            Text(
                              'Help & Support ',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            Spacer(),
                            if (this.hasNavigation)
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.black,
                                size: 10 * 3.5,
                              ),

                          ],

                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                      height: 10 * 5.5,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10 * 3,
                      ).copyWith(
                        bottom: 10 * 2,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * 3),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ],
                      ),
                      child: GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.settings,
                              color: Colors.black,
                              size: 10 * 2.5,
                            ),
                            SizedBox(width: 10 * 1.5),
                            Text(
                              'Settings ',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            Spacer(),
                            if (this.hasNavigation)
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.black,
                                size: 10 * 3.5,
                              ),

                          ],

                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                      height: 10 * 5.5,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10 * 3,
                      ).copyWith(
                        bottom: 10 * 2,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * 3),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                          // ..pop()
                          ..pop(),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.power,
                              color: Colors.black,
                              size: 10 * 2.5,
                            ),
                            SizedBox(width: 10 * 1.5),
                            Text(
                              'Log Out',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            Spacer(),
                            if (this.hasNavigation)
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.black,
                                size: 10 * 3.5,
                              ),

                          ],

                        ),
                      )),


                ],
              ),
            )));
  }
}
