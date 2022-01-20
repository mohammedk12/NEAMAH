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
        title: Text('Neamah'),
      ),
      body: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('report an issue:'),
              TextField(
                onChanged: (val) {
                  issue = val;
                },
                decoration:
                    InputDecoration(hintText: 'please describe your issue'),
              ),
              ElevatedButton(
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
                  child: Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}
