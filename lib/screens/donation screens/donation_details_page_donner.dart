import 'package:flutter/material.dart';

class donation_details_page_donner extends StatelessWidget {
  //stateless variables should always be final
  final String email;
  final String foodOrCloths;
  final String dropdownValue;
  final String donationStatus;
  final String discreption;
  final String time;
  final String donationClaimer;
  final String image;
  final Function() deleteCallBack;
  final Function() locationCallBack;

  donation_details_page_donner(
      this.email,
      this.foodOrCloths,
      this.dropdownValue,
      this.donationStatus,
      this.discreption,
      this.time,
      this.donationClaimer,
      this.image,
      this.deleteCallBack,
      this.locationCallBack);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neamah'),
      ),
      body: Material(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(email),
            Text(foodOrCloths),
            Text(
              dropdownValue,
            ),
            Text(donationStatus),
            Text(discreption),
            Text(time),
            Text(donationClaimer),
            Image.network(
              image,
              height: 100,
              width: 100,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    deleteCallBack();
                    Navigator.pop(context);
                  },
                  child: Text('Delete Donation')),
              SizedBox(width: 30),
              ElevatedButton(
                  onPressed: () {
                    locationCallBack();
                  },
                  child: Text('check Location'))
            ]),
          ],
        ),
        color: Colors.white,
      )),
    );
  }
}
