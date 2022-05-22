import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neamah/components/donation_data.dart';
import 'package:neamah/screens/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neamah/screens/donation%20screens/donation_details_page_PIN.dart';
import 'package:provider/provider.dart';
import 'package:neamah/screens/report_issue.dart';
import 'package:neamah/screens/donation%20screens/claimed_donation_page_PIN.dart';
import 'package:neamah/components/user_data.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:geolocator/geolocator.dart';

final _firestore = FirebaseFirestore.instance;

class PIN_screen extends StatefulWidget {
  var location;

  List w = [];
  PIN_screen(this.location) {
    w = [viewDonations(this.location), editProfile()];
  }

  @override
  _PIN_screenState createState() => _PIN_screenState();
}

class _PIN_screenState extends State<PIN_screen> {
  int NavigationBarIndex = 0;
  int allowableDistance = 5; // in km

  // IF YOU NEED TO USE CONTEXT DO IT DOWN IN onTap
  // if something in the body type it here, else you can type it down

  int calcDis(var address) {
    double distanceInMeters = Geolocator.distanceBetween(
        widget.location.latitude,
        widget.location.longitude,
        address.latitude,
        address.longitude);

    return (distanceInMeters / 1000).toInt();
  }

  void fillProvidersFromFB() async {
    var claimed_donation_id = await user_data.getCurrentUserClaimedDON_id();

    if (claimed_donation_id.toString().isEmpty) {
      final donations =
          await _firestore.collection('donations').orderBy('timestamp').get();

      Provider.of<donation_data>(context, listen: false)
          .donations
          .clear(); // emptying the screen before bringing all donations from the DB

      for (var donation in donations.docs.reversed) {
        if (calcDis(donation.data()['address']) < allowableDistance) {
          print(calcDis(donation.data()['address']));
          var _imageFile = donation.data()['image'];
          var address = donation.data()['address'];
          var foodOrCloths = donation.data()['donation_type'];
          var donationStatus = donation.data()['donation_status'];
          var dropdownValue = donation.data()['QuantityPerPerson'];
          var discreption = donation.data()['discreption'];
          var email = donation.data()['email'];
          var time = donation.data()['timestamp'].toDate();
          var donationClaimer = donation.data()['donation_claimer'];
          var claimerPhone = donation.data()['claimer_phone'];
          var id = donation.id;
          Provider.of<donation_data>(context,
                  listen:
                      false) // listen: false , always type it or you will get an error
              .add_Donation(
                  _imageFile,
                  address,
                  foodOrCloths,
                  donationStatus,
                  dropdownValue,
                  discreption,
                  id,
                  email,
                  time,
                  donationClaimer,
                  claimerPhone);
        }
      }
    } else {
      final donations = await _firestore
          .collection('donations')
          .doc('$claimed_donation_id')
          .get();

      Provider.of<donation_data>(context, listen: false)
          .donations
          .clear(); // emtying the screen before bringing all donations from the DB

      var _imageFile = donations.data()!['image'];
      var address = donations.data()!['address'];
      var foodOrCloths = donations.data()!['donation_type'];
      var donationStatus = donations.data()!['donation_status'];
      var dropdownValue = donations.data()!['QuantityPerPerson'];
      var discreption = donations.data()!['discreption'];
      var email = donations.data()!['email'];
      var time = donations.data()!['timestamp'].toDate();
      var id = donations.id;
      var donationClaimer = donations.data()!['donation_claimer'];
      var claimerPhone = donations.data()!['claimer_phone'];

      Provider.of<donation_data>(context,
              listen:
                  false) // listen: false , always type it or you will get an error
          .add_Donation(
              _imageFile,
              address,
              foodOrCloths,
              donationStatus,
              dropdownValue,
              discreption,
              id,
              email,
              time,
              donationClaimer,
              claimerPhone);

      showOkAlertDialog(
        context: context,
        title: '!!!',
        message:
            'go claim your donation or cancel claiming! (after that you well be able to see all donations)',
      );
    }
  }

  @override
  void initState() {
    fillProvidersFromFB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.of(context)..pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: IconButton(
                icon: NavigationBarIndex == 0
                    ? Icon(Icons.refresh_rounded)
                    : Text(''),
                onPressed: NavigationBarIndex == 0
                    ? () {
                        fillProvidersFromFB();
                      }
                    : null,
              ),
              onPressed: () {
                fillProvidersFromFB();
              }),
        ],
        title: Center(child: Text('NA\'MAH')),
        backgroundColor: Color(0xFF004086),
      ),
      body: widget.w.elementAt(NavigationBarIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF004086),
        currentIndex: NavigationBarIndex,
        onTap: (chosedTab) {
          setState(() {
            chosedTab == 0 ? NavigationBarIndex = 0 : {};

            chosedTab == 1 ? NavigationBarIndex = 1 : {};

            fillProvidersFromFB();
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list, color: Colors.white),
              title: Text(
                'View Donations',
                style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              backgroundColor: Colors.blue,
              title: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class viewDonations extends StatelessWidget {
  var loc;
  bool claimed = false;

  viewDonations(this.loc);

  @override
  Widget build(BuildContext context) {
    final DD_provider = Provider.of<donation_data>(context);
    final DD_provider_false =
        Provider.of<donation_data>(context, listen: false);

    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(DD_provider.donations.length, (index) {
        String calcDistence() {
          double distanceInMeters = Geolocator.distanceBetween(
            loc.latitude,
            loc.longitude,
            DD_provider_false.donations[index].address.latitude,
            DD_provider_false.donations[index].address.longitude,
          );

          return (distanceInMeters / 1000).toInt().toString();
        }

        String email = DD_provider.donations[index].email;
        String foodOrCloths = DD_provider.donations[index].foodOrCloths;
        String dropdownValue =
            DD_provider.donations[index].dropdownValue.toString();
        String donationStatus = DD_provider.donations[index].donationStatus;
        String discreption = DD_provider.donations[index].discreption;
        String time = DD_provider.donations[index].time.toString();
        String donationClaimer = DD_provider.donations[index].donationClaimer;
        String claimerPhone = DD_provider.donations[index].claimerPhone;
        String image = DD_provider.donations[index].imageFile;
        // var clr =
        //     DD_provider.donations[index].donationStatus.toString().length !=
        //             9 //completed or cancelled
        //         ? Colors.blue
        //         : Colors.grey;

        var clr =
            DD_provider.donations[index].donationStatus.toString().length !=
                        9 &&
                    (user_data.getCurrentUserEmail() ==
                            DD_provider.donations[index].donationClaimer ||
                        DD_provider.donations[index].donationClaimer ==
                            'no claimer yet')
                ? Colors.blue
                : Colors.grey;

        return Center(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 200,
                width: 165,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Image.network(
                      DD_provider.donations[index].imageFile,
                      fit: BoxFit.fill,
                      height: 140,
                      width: 130,
                    ),
                    SizedBox(height: 3),
                    Text(calcDistence() + 'KM'),
                    SizedBox(height: 3),
                    Text(DD_provider.donations[index].donationStatus),
                    SizedBox(height: 3.5),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return donation_details_page_PIN(
                    email,
                    foodOrCloths,
                    dropdownValue,
                    donationStatus,
                    discreption,
                    time,
                    donationClaimer,
                    image, () async {
                  GeoPoint gp =
                      Provider.of<donation_data>(context, listen: false)
                          .donations[index]
                          .address;

                  //  double distanceBetweenTwoPoints = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);

                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      //  return map(Location.latitude, Location.longitude);
                      return GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(gp.latitude, gp.longitude),
                            zoom: 20),
                        markers: {
                          Marker(
                              markerId: MarkerId('1'),
                              position: LatLng(gp.latitude, gp.longitude))
                        },
                      );
                    }),
                  );
                }, () async {
                  if (DD_provider.donations[index].donationStatus.toString() ==
                      'Not Claimed') {
                    Provider.of<donation_data>(context, listen: false)
                        .updateStatus(
                            Provider.of<donation_data>(context, listen: false)
                                .donations[index],
                            'Claimed');

                    user_data.setCurrentUserClaimedDON_id(
                        Provider.of<donation_data>(context, listen: false)
                            .donations[index]
                            .id);

                    // assigning the claimer to the donation ??

                    Provider.of<donation_data>(context, listen: false)
                        .setDonationClaimer(
                            Provider.of<donation_data>(context, listen: false)
                                .donations[index],
                            '${user_data.getCurrentUserEmail()}');

                    var phone = await user_data.getCurrentUserPhone();

                    Provider.of<donation_data>(context, listen: false)
                        .setDonationClaimerPhone(
                            Provider.of<donation_data>(context, listen: false)
                                .donations[index],
                            '$phone');

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return claimed_donation_page(DD_provider_false, index);
                      }),
                    );
                  } else if (DD_provider.donations[index].donationStatus
                          .toString() ==
                      'Claimed') {
                    if (user_data.getCurrentUserEmail() ==
                        DD_provider.donations[index].donationClaimer) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return claimed_donation_page(
                              DD_provider_false, index);
                        }),
                      );
                    } else {
                      print('dose not equal !');
                    }
                  } else {
                    // if cancelled or completed
                    print('false');
                  }
                }, () {
                  print('hey you');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return report_issue(DD_provider.donations[index].id);
                    }),
                  );
                }, clr);
              }));
            },
          ),
        );
      }),
    );
  }
}
