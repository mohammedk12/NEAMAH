import 'package:flutter/material.dart';

class donation_details_page_PIN extends StatelessWidget {
  //stateless variables should always be final
  final String email;
  final String foodOrCloths;
  final String dropdownValue;
  final String donationStatus;
  final String discreption;
  final String time;
  final String donationClaimer;
  final String image;
  final Function() locationCallBack;
  final Function() claimCallBack;
  final Function() reportCallBack;
  final clr;

  donation_details_page_PIN(
      this.email,
      this.foodOrCloths,
      this.dropdownValue,
      this.donationStatus,
      this.discreption,
      this.time,
      this.donationClaimer,
      this.image,
      this.locationCallBack,
      this.claimCallBack,
      this.reportCallBack,
      this.clr);

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
                    locationCallBack();
                  },
                  child: Text('check Location')),
              SizedBox(width: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: clr),
                  onPressed: () {
                    claimCallBack();
                    //  Navigator.of(context)..pop();
                  },
                  child: Text('Claim Donation')),
              SizedBox(width: 5),
              ElevatedButton(
                  onPressed: () {
                    reportCallBack();
                  },
                  child: Text('Report Donation')),
            ]),
          ],
        ),
        color: Colors.white,
      )),
    );
  }
}
