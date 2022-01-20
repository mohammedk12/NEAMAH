import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neamah/components/donation_data.dart';
import 'package:neamah/screens/Donner_addDonation.dart';
import 'package:neamah/screens/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:neamah/components/user_data.dart';
import 'package:neamah/screens/donation%20screens/donation_details_page_donner.dart';

final _firestore = FirebaseFirestore.instance;

class Donner_view_donations_screen extends StatefulWidget {
  @override
  _Donner_view_donations_screenState createState() =>
      _Donner_view_donations_screenState();
}

class _Donner_view_donations_screenState
    extends State<Donner_view_donations_screen> {
  int NavigationBarIndex = 0;

  // IF YOU NEED TO USE CONTEXT DO IT DOWN IN onTap
  // if something in the body type it here, else you can type it down
  List w = [myDonations(), Text(''), editProfile()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context)
              ..pop()
              ..pop(),
          ),
          title: Center(
            child: Text('NEAMAH'),
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: w.elementAt(NavigationBarIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: NavigationBarIndex,
          onTap: (chosedTab) {
            setState(() {
              chosedTab == 0 ? NavigationBarIndex = 0 : {};

              // ---
              chosedTab == 1
                  ? {
                      showModalBottomSheet(
                        isScrollControlled:
                            true, // so that keyboard won't cover add button on the sheet
                        context: context,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: addDonation(),
                        ),
                      ),
                      NavigationBarIndex = 0,
                    }
                  : {};

              // ---

              chosedTab == 2 ? NavigationBarIndex = 2 : {};

              //     fillProvidersFromFB();
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.view_list), title: Text('my donations')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue,
                title: Text('add donation')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                backgroundColor: Colors.blue,
                title: Text('edit profile')),
          ],
        ),
      ),
    );
  }
}

/*

notice that here we work with streams, live connection to database

 */

class myDonations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection('donations').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            // is the snapshot that came from the stream empty or not ?
            final donations = snapshot.data!.docs.reversed;

            Provider.of<donation_data>(context, listen: false)
                .donations
                .clear();

            for (var donation in donations) {
              if (donation.get('email') == user_data.getCurrentUserEmail()) {
                final _imageFile = donation.get('image');
                final address = donation.get('address');
                final foodOrCloths = donation.get('food_or_cloths');
                final donationStatus = donation.get('donation_status');
                final dropdownValue = donation.get('dropdownvalue');
                final discreption = donation.get('discreption');
                final email = donation.get('email');
                final time1 = donation.get('timestamp');
                final time = time1 == null ? null : time1.toDate();
                final id = donation.id;
                final donationClaimer = donation.get('donation_claimer');
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
                        donationClaimer);
              }
            }
          }

          return GridView.count(
            // crossAxisCount is the number of columns
            crossAxisCount: 2,
            // This creates two columns with two items in each column
            children: List.generate(
                Provider.of<donation_data>(context, listen: false)
                    .donations
                    .length, (index) {
              print(index);

              final DD_provider =
                  Provider.of<donation_data>(context, listen: false);

              String email = DD_provider.donations[index].email;
              String foodOrCloths = DD_provider.donations[index].foodOrCloths;
              String dropdownValue =
                  DD_provider.donations[index].dropdownValue.toString();
              String donationStatus =
                  DD_provider.donations[index].donationStatus;
              String discreption = DD_provider.donations[index].discreption;
              String time = DD_provider.donations[index].time.toString();
              String image = DD_provider.donations[index].imageFile;
              String donationClaimer =
                  DD_provider.donations[index].donationClaimer;

              return Center(
                child: InkWell(
                  child: Container(
                    height: 200,
                    width: 150,
                    color: Colors.lightBlue,
                    child: Column(
                      children: [
                        Text(discreption),
                        Text(email),
                        //    Text(foodOrCloths),
                        // Text(dropdownValue),
                        Text(donationStatus),
                        //    Text(time),
                        //   Text(donationClaimer),
                        Image.network(
                          image,
                          height: 100,
                          width: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<donation_data>(context,
                                          listen: false)
                                      .delete_Donation(
                                          Provider.of<donation_data>(context,
                                                  listen: false)
                                              .donations[index]);
                                  print('deleted!');
                                },
                                child: Text('Delete Donation')),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       GeoPoint gp = Provider.of<donation_data>(
                            //               context,
                            //               listen: false)
                            //           .donations[index]
                            //           .address;
                            //
                            //       //  double distanceBetweenTwoPoints = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
                            //
                            //       await Navigator.push(
                            //         context,
                            //         MaterialPageRoute(builder: (context) {
                            //           //  return map(Location.latitude, Location.longitude);
                            //           return GoogleMap(
                            //             zoomControlsEnabled: false,
                            //             initialCameraPosition: CameraPosition(
                            //                 target: LatLng(
                            //                     gp.latitude, gp.longitude),
                            //                 zoom: 20),
                            //             markers: {
                            //               Marker(
                            //                   markerId: MarkerId('1'),
                            //                   position: LatLng(
                            //                       gp.latitude, gp.longitude))
                            //             },
                            //           );
                            //         }),
                            //       );
                            //     },
                            //     child: Text('check location')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return donation_details_page_donner(
                          email,
                          foodOrCloths,
                          dropdownValue,
                          donationStatus,
                          discreption,
                          time,
                          donationClaimer,
                          image, () {
                        Provider.of<donation_data>(context, listen: false)
                            .delete_Donation(Provider.of<donation_data>(context,
                                    listen: false)
                                .donations[index]);
                      }, () async {
                        GeoPoint gp =
                            Provider.of<donation_data>(context, listen: false)
                                .donations[index]
                                .address;

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
                      });
                    }));
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
