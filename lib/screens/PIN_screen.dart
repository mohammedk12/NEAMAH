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
  int allowableDistance = 10;
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
        //   if (calcDis(donation.data()['address']) < allowableDistance) {
        print(calcDis(donation.data()['address']));
        var _imageFile = donation.data()['image'];
        var address = donation.data()['address'];
        var foodOrCloths = donation.data()['food_or_cloths'];
        var donationStatus = donation.data()['donation_status'];
        var dropdownValue = donation.data()['dropdownvalue'];
        var discreption = donation.data()['discreption'];
        var email = donation.data()['email'];
        var time = donation.data()['timestamp'].toDate();
        var donationClaimer = donation.data()['donation_claimer'];
        var id = donation.id;
        Provider.of<donation_data>(context,
                listen:
                    false) // listen: false , always type it or you will get an error
            .add_Donation(_imageFile, address, foodOrCloths, donationStatus,
                dropdownValue, discreption, id, email, time, donationClaimer);
        //  }
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
      var foodOrCloths = donations.data()!['food_or_cloths'];
      var donationStatus = donations.data()!['donation_status'];
      var dropdownValue = donations.data()!['dropdownvalue'];
      var discreption = donations.data()!['discreption'];
      var email = donations.data()!['email'];
      var time = donations.data()!['timestamp'].toDate();
      var id = donations.id;
      var donationClaimer = donations.data()!['donation_claimer'];

      Provider.of<donation_data>(context,
              listen:
                  false) // listen: false , always type it or you will get an error
          .add_Donation(_imageFile, address, foodOrCloths, donationStatus,
              dropdownValue, discreption, id, email, time, donationClaimer);

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

          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context)
            ..pop()
            ..pop(),
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
              icon: Icon(Icons.view_list), title: Text('view donations')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              backgroundColor: Colors.blue,
              title: Text('edit profile')),
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
            child: Container(
              height: 200,
              width: 150,
              color: Colors.lightBlue,
              child: Column(
                children: [
                  Text(calcDistence() + 'KM'),
                  Text(DD_provider.donations[index].email),
                  // Text(DD_provider.donations[index].foodOrCloths),
                  // Text(DD_provider.donations[index].dropdownValue.toString()),
                  // Text(DD_provider.donations[index].donationStatus),
                  Text(DD_provider.donations[index].discreption),
                  // Text(DD_provider.donations[index].time.toString()),
                  Text(DD_provider.donations[index].donationClaimer),
                  Image.network(
                    DD_provider.donations[index].imageFile,
                    height: 88,
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       GeoPoint gp = Provider.of<donation_data>(context,
                      //               listen: false)
                      //           .donations[index]
                      //           .address;
                      //       await Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) {
                      //           //  return map(Location.latitude, Location.longitude);
                      //           return GoogleMap(
                      //             zoomControlsEnabled: false,
                      //             initialCameraPosition: CameraPosition(
                      //                 target: LatLng(gp.latitude, gp.longitude),
                      //                 zoom: 20),
                      //             markers: {
                      //               Marker(
                      //                   markerId: MarkerId('1'),
                      //                   position:
                      //                       LatLng(gp.latitude, gp.longitude))
                      //             },
                      //           );
                      //         }),
                      //       );
                      //     },
                      //     child: Text('check location')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: DD_provider.donations[index].donationStatus
                                          .toString()
                                          .length !=
                                      9 &&
                                  (user_data.getCurrentUserEmail() ==
                                          DD_provider.donations[index]
                                              .donationClaimer ||
                                      DD_provider.donations[index]
                                              .donationClaimer ==
                                          'no claimer yet') //not equal completed or cancelled
                              ? ElevatedButton.styleFrom(primary: Colors.blue)
                              : ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () async {
                            if (DD_provider.donations[index].donationStatus
                                    .toString() ==
                                'not claimed') {
                              //  fillProvidersFromFB();

                              Provider.of<donation_data>(context, listen: false)
                                  .updateStatus(
                                      Provider.of<donation_data>(context,
                                              listen: false)
                                          .donations[index],
                                      'Claimed');

                              Provider.of<donation_data>(context, listen: false)
                                  .setDonationClaimer(
                                      Provider.of<donation_data>(context,
                                              listen: false)
                                          .donations[index],
                                      '${user_data.getCurrentUserEmail()}');

                              user_data.setCurrentUserClaimedDON_id(
                                  Provider.of<donation_data>(context,
                                          listen: false)
                                      .donations[index]
                                      .id);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return claimed_donation_page(
                                      DD_provider_false, index);
                                }),
                              );
                            } else if (DD_provider
                                    .donations[index].donationStatus
                                    .toString() ==
                                'Claimed') {
                              if (user_data.getCurrentUserEmail() ==
                                  DD_provider
                                      .donations[index].donationClaimer) {
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
                          },
                          child: Text(
                            'Claim',
                          )),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) {
                      //         return report_issue(
                      //             DD_provider.donations[index].id);
                      //       }),
                      //     );
                      //   },
                      //   child: Text('report'),
                      // )
                    ],
                  ),
                ],
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
                      'not claimed') {
                    Provider.of<donation_data>(context, listen: false)
                        .updateStatus(
                            Provider.of<donation_data>(context, listen: false)
                                .donations[index],
                            'Claimed');

                    user_data.setCurrentUserClaimedDON_id(
                        Provider.of<donation_data>(context, listen: false)
                            .donations[index]
                            .id);

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
