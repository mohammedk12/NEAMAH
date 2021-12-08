import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neamah/components/donation_data.dart';
import 'package:neamah/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:neamah/components/Donner_addDonation.dart';
import 'package:neamah/components/Location.dart';
import 'package:neamah/components/setLocationButton.dart';
import 'package:neamah/components/GoogleMap.dart';
import 'package:neamah/components/Donner_editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:map_picker/map_picker.dart';

final _firestore = FirebaseFirestore.instance;
User? activeUser;

class Donner_view_donations_screen extends StatefulWidget {
  @override
  _Donner_view_donations_screenState createState() =>
      _Donner_view_donations_screenState();
}

class _Donner_view_donations_screenState
    extends State<Donner_view_donations_screen> {
  final _auth = FirebaseAuth.instance;
  int NavigationBarIndex = 0;

  // IF YOU NEED TO USE CONTEXT DO IT DOWN IN onTap
  // if something in the body type it here, else you can type it down
  List w = [viewDonations(), Text(''), editProfile()];

  void getDonationsFromDBtoProvider() async {
    final donations =
        await _firestore.collection('donations').orderBy('timestamp').get();
    Provider.of<donation_data>(context, listen: false)
        .donations
        .clear(); // emtying the screen before bringing all donations from the DB

    for (var donation in donations.docs.reversed) {
      var d = donation.data().values;
      if (d.elementAt(7) == activeUser!.email) {
        var _imageFile = d.elementAt(0);
        var address = d.elementAt(1);
        var foodOrCloths = d.elementAt(2);
        var donationStatus = d.elementAt(3);
        var dropdownValue = d.elementAt(4);
        var discreption = d.elementAt(5);
        var id = d.elementAt(6);
        var email = d.elementAt(7);

        Provider.of<donation_data>(context,
                listen:
                    false) // listen: false , always type it or you will get an error
            .add_Donation(_imageFile, address, foodOrCloths, donationStatus,
                dropdownValue, discreption, id, email);
      }
    }
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    getDonationsFromDBtoProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh_rounded),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);
                getDonationsFromDBtoProvider();
              }),
        ],
        title: Text('NEAMAH'),
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

            getDonationsFromDBtoProvider();
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
    );
  }
}

class viewDonations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              title: Container(
            color: Colors.lightBlue,
            child: Column(
              children: [
                Text(Provider.of<donation_data>(context).donations[index].id),
                Text(
                    Provider.of<donation_data>(context).donations[index].email),
                Text(Provider.of<donation_data>(context)
                    .donations[index]
                    .foodOrCloths),
                Text(Provider.of<donation_data>(context)
                    .donations[index]
                    .dropdownValue
                    .toString()),
                Text(Provider.of<donation_data>(context)
                    .donations[index]
                    .donationStatus),
                Text(Provider.of<donation_data>(context)
                    .donations[index]
                    .discreption),
                Image.network(
                  Provider.of<donation_data>(context)
                      .donations[index]
                      .imageFile,
                  height: 200,
                  width: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final donations = await _firestore
                              .collection('donations')
                              .orderBy('timestamp')
                              .get();

                          for (var donation in donations.docs.reversed) {
                            var d = donation.data().values;
                            if (d.elementAt(6) ==
                                Provider.of<donation_data>(context,
                                        listen: false)
                                    .donations[index]
                                    .id) {
                              await _firestore
                                  .collection('donations')
                                  .doc(donation.id)
                                  .delete();
                              //  donation.id;
                            }
                          }

                          Provider.of<donation_data>(context, listen: false)
                              .delete_Donation(Provider.of<donation_data>(
                                      context,
                                      listen: false)
                                  .donations[index]);
                        },
                        child: Text('Delete Donation')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
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
                                      position:
                                          LatLng(gp.latitude, gp.longitude))
                                },
                              );
                            }),
                          );
                        },
                        child: Text('check location')),
                  ],
                ),

                // Image(
                //   image: Provider.of<donation_data>(context)
                //               .donations[index]
                //               .imageFile ==
                //           null
                //       ? AssetImage('images/download.png') as ImageProvider
                //       : AssetImage(Provider.of<donation_data>(context)
                //           .donations[index]
                //           .imageFile),
                // ),
                // Text(Provider.of<donation_data>(context)
                //     .donations[index]
                //     .imageFile==null?AssetImage('images/download.png') as ImageProvider),
              ],
            ),
          )

              //    Text(Provider.of<donation_data>(context).donations[index]._imageFile.toString()),
              );
        },
        itemCount: Provider.of<donation_data>(context).donations.length,
      ),
    );
  }
}
