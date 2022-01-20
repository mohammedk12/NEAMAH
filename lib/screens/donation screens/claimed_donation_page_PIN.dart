import 'package:flutter/material.dart';
import 'package:neamah/components/user_data.dart';
import 'package:neamah/screens/innetial_screen.dart';
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
          automaticallyImplyLeading: false,
          title: Center(child: Text('...')),
        ),
        body: Material(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.done),
                  Text('you have claimed the donation !'),
                  ElevatedButton(
                      onPressed: () async {
                        final url =
                            'https://www.google.com/maps/search/?api=1&query=${Donation.donations[index].address.latitude},${Donation.donations[index].address.longitude}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text('go to the location')),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          Donation.updateStatus(
                              Donation.donations[index], 'Completed');
                          user_data.setCurrentUserClaimedDON_id('');

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return innetial_screen();
                            }),
                          );
                        },
                        child: Text('confirm claiming'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Donation.updateStatus(
                              Donation.donations[index], 'Cancelled');
                          user_data.setCurrentUserClaimedDON_id('');

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return innetial_screen();
                            }),
                          );
                        },
                        child: Text('cancel claiming'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
