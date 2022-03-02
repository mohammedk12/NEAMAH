import 'package:flutter/cupertino.dart';
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
        backgroundColor: Color(0xFF004086),
        centerTitle: true,
        title: Text('NA\'MAH'),
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.trash,
                color: Colors.white,
              ),
              onPressed: () {
                deleteCallBack();
                Navigator.pop(context);
              },
            )
          ],
      ),
      body: Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
             
              child: Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[ Container(


        //  mainAxisAlignment: MainAxisAlignment.center,
           // children: [
                   // Text(email),
                       child: Center(
                         child: Image.network(
                                       image,
                                       fit: BoxFit.fill,
                                       height: 200,
                                       width: 200,
        ),
                       ),
                     ),
                      SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 350,height: 400,

                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child:Column(
                      children:[
                      Text('Type of Donation : '+foodOrCloths.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                      SizedBox(height: 20),

                      Text('Description :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      Text(discreption),

                      SizedBox(height: 50),

                   Text('Quantity : '+dropdownValue,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),

                      SizedBox(height: 20),

                      Text('Uploaded at : '+time,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),

                      SizedBox(height: 20),

                      Text('Status: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),

                      Text(donationStatus,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
         //   Text(donationClaimer),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [

                          ElevatedButton(
                              onPressed: () {
                                locationCallBack();
                              },
                              child: Text('check Location'))
                        ]),
                      ])),
                    ),

                  ],
        ),
                ),
              ),
            ),
       // color: Colors.white,
       ),
          )
    ;
  }
}
