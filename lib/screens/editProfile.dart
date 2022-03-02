import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neamah/screens/report_issue.dart';
import 'package:neamah/components/user_data.dart';
import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:neamah/screens/donation screens/changePassword.dart';
class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String new_password = '';
  String new_retypedPassword = '';
  String id = '';
  final bool hasNavigation = true;

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
      backgroundColor: Color(0xFF004086),
       body: Padding( padding: EdgeInsets.all(15.0),

        child:   Expanded(
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
                        backgroundColor: Colors.black,
                        radius: 10 * 5,
                        child: Icon(Icons.person, size: 90,color: Colors.white,),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10 * 2),
                Text(
                  '$id',style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),

                ),
                SizedBox(height: 10 * 0.5),
                Text(
                  '${user_data.getCurrentUserEmail()}',style: TextStyle(color: Colors.white),

                ),
                SizedBox(height: 10 * 2),

       //   mainAxisAlignment: MainAxisAlignment.center,


              SizedBox(
                height: 15,
              ),

                 Container(
                    height: 10 * 5.5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10 * 3,
                    ).copyWith(
                      bottom: 10 * 2,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12 ,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * 3),
                      color: Color(0xFF005086),
                    ),
                    child: GestureDetector(
                    onTap:(){
                      //print('Hi');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return changePassword();

                        }),
                      );
                    } ,
                      child: Row(children: <Widget>[

                        Icon(
                          CupertinoIcons.lock,
                          color: Colors.white,
                          size: 10 * 2.5,
                        ),
                        SizedBox(width: 10 * 1.5),
                        Text(
                          'Change Password ',
                          style: TextStyle(fontSize: 17,color: Colors.white),

                        ),
                        Spacer(),
                        if (this.hasNavigation)
                        Icon(

                          CupertinoIcons.chevron_forward,
                          color: Colors.white,
                          size: 10 * 3.5,

                        ),
                      // Spacer()
                  //    FloatingActionButton(onPressed:(){} )
                      ],
                   //     child: RaisedButton(
                  //          onPress:
                   //     )
                      ),
                    )
                ),
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
                      horizontal: 12 ,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * 3),
                      color: Color(0xFF005086),
                    ),
                    child: GestureDetector(
                      onTap:(){
                        //print('Hi');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return report_issue(
                                'this report is not related to a specific donation');
                          }),
                        );
                      } ,
                      child: Row(children: <Widget>[

                        Icon(
                          CupertinoIcons.question_circle,
                          color: Colors.white,
                          size: 10 * 2.5,
                        ),
                        SizedBox(width: 10 * 1.5),
                        Text(
                          'Help & Support ',
                          style: TextStyle(fontSize: 17,color: Colors.white),

                        ),
                        Spacer(),
                        if (this.hasNavigation)
                          Icon(

                            CupertinoIcons.chevron_forward,
                            color: Colors.white,
                            size: 10 * 3.5,

                          ),
                        // Spacer()
                        //    FloatingActionButton(onPressed:(){} )
                      ],
                        //     child: RaisedButton(
                        //          onPress:
                        //     )
                      ),
                    )
                ),
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
                      horizontal: 12 ,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * 3),
                      color: Color(0xFF005086),
                    ),
                    child: GestureDetector(
                      child: Row(children: <Widget>[

                        Icon(
                          CupertinoIcons.settings,
                          color: Colors.white,
                          size: 10 * 2.5,
                        ),
                        SizedBox(width: 10 * 1.5),
                        Text(
                          'Settings ',
                          style: TextStyle(fontSize: 17,color: Colors.white),

                        ),
                        Spacer(),
                        if (this.hasNavigation)
                          Icon(

                            CupertinoIcons.chevron_forward,
                            color: Colors.white,
                            size: 10 * 3.5,

                          ),
                        // Spacer()
                        //    FloatingActionButton(onPressed:(){} )
                      ],
                        //     child: RaisedButton(
                        //          onPress:
                        //     )
                      ),
                    )
                ),
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
                      horizontal: 12 ,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * 3),
                      color: Color(0xFF005086),
                    ),
                    child: GestureDetector(
                      onTap:() => Navigator.of(context)
                       // ..pop()
                        ..pop(),

                      child: Row(children: <Widget>[

                        Icon(
                          CupertinoIcons.power,
                          color: Colors.white,
                          size: 10 * 2.5,
                        ),
                        SizedBox(width: 10 * 1.5),
                        Text(
                          'Log Out',
                          style: TextStyle(fontSize: 17,color: Colors.white),

                        ),
                        Spacer(),
                        if (this.hasNavigation)
                          Icon(

                            CupertinoIcons.chevron_forward,
                            color: Colors.white,
                            size: 10 * 3.5,

                          ),
                        // Spacer()
                        //    FloatingActionButton(onPressed:(){} )
                      ],
                        //     child: RaisedButton(
                        //          onPress:
                        //     )
                      ),
                    )
                ),

              //  ClipRRect(

              //      borderRadius: BorderRadius.circular(8),
              //     child: FlatButton(
              //      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
              //       color: Color(0xFF007AFF),
              //       onPressed: () {
              //         Navigator.push(
              //          context,
              //         MaterialPageRoute(builder: (context) {
              //           return testProfile(
              //               );
              //          }),
              //        );
              //        },
              //        child: Text('profile?',style: TextStyle(color: Colors.white ),),
              //       )
              //   ),
            ],
        ),
          ))));
  }
}
