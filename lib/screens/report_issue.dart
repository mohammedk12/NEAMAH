import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neamah/components/user_data.dart';

final _firestore = FirebaseFirestore.instance;

class report_issue extends StatelessWidget {
  final String donation_id; // passed from PIN_screen
  String issue = '';

  report_issue(this.donation_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004086),
        centerTitle: true,
        title: Text('Report an Issue'),
      ),
      body:Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
      reverse: true,
          child: Column(
            children: [
              SizedBox(height: 40),
              TextField(
                onChanged: (val) {
                  issue = val;
                },

                decoration: InputDecoration(hintText: 'Describe Your Issue',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFFD1D0D4))
                ),
              ),

              SizedBox(height: 160),

          ClipRRect(
                 borderRadius: BorderRadius.circular(8),
                 child: FlatButton(
                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 75),//55
                 color: Color(0xFF007AFF),
                 onPressed: () {

                    if (issue.isEmpty) {
                      showOkAlertDialog(
                        context: context,
                        title: 'error',
                        message: 'some data is missing',
                      );
                    } else {
                      _firestore.collection('reports').add({
                        'discerption': issue,
                        'email': user_data.getCurrentUserEmail(),
                        'donation_id': donation_id,
                      });
                      showOkAlertDialog(
                        context: context,
                        title: Icon(Icons.gpp_good_sharp).toString(),
                        message:
                            'report has been sent, we will contact you soon',
                      ).then((value) => Navigator.pop(context));
                    }
                  },
                  child: Text('submit',
                    style: TextStyle(color: Colors.white),
                  ))
          )],
          ),
        ),
      ),
    );
  }
}
