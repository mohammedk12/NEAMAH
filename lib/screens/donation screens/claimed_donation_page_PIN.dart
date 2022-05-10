import 'package:flutter/material.dart';
import 'package:neamah/components/user_data.dart';
import 'package:neamah/screens/editProfile.dart';
import 'package:neamah/screens/PIN_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class claimed_donation_page extends StatelessWidget {
  final Donation;
  final index;

  claimed_donation_page(this.Donation, this.index);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004086),
          centerTitle: true,
          title: Text('NA\'MAH'),
        ),
        body: Container(
          child: Column(children: [
            SizedBox(height: 180),
            Text('You have claimed the donation!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            SizedBox(height: 30),
            Container(
              width: 170,
              height: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  color: Colors.blue[800],
                  onPressed: () async {
                    final url =
                        'https://www.google.com/maps/search/?api=1&query=';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    'Get Directions',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 170,
                height: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FlatButton(
                    color: Colors.blue[800],
                    onPressed: () {
                      Donation.updateStatus(
                          Donation.donations[index], 'Completed');
                      user_data.setCurrentUserClaimedDON_id('');

                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                    child: Text(
                      'Confirm Claiming',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                width: 170,
                height: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FlatButton(
                    color: Colors.blue[800],
                    onPressed: () {
                      Donation.updateStatus(
                          Donation.donations[index], 'Cancelled');
                      user_data.setCurrentUserClaimedDON_id('');

                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                    child: Text(
                      'Cancel Claiming',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
