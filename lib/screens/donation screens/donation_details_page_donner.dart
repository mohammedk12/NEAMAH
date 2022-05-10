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
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,

        child: Stack(
          children: [
            Positioned(
              left: 0,
                right: 0,
                child: Container(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    //height: 250,
                    height: 320,
                  //  height: 350,
                  ),
            )
            ),
            Positioned(
                left: 10,
                top: 17,
                child: Row(
                  children: [

                    IconButton(
                      icon: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.blue[800],
                        size: 10 * 4,
                      ),
                      onPressed: () {
            TODO:
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
            ),
            Positioned(
                right: 10,
                top: 20,
                child: Row(
                  children: [

                    IconButton(
                      icon: Icon(
                        CupertinoIcons.trash_fill,
                        color: Colors.blue[800],
                        size: 10 * 3.5,
                      ),
                      onPressed: () {
                        deleteCallBack();
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
            ),
            Positioned(
              top: 290,
                child: Container(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 25),
              width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
              color: Colors.white,
                    borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                 ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Donation Type: '+foodOrCloths.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,),),
                        ],
                      ),

                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Description :',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),

                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          FractionalTranslation(
                          translation: Offset(0, 0),
                      child: Container(
                       width: 300,
                        height: 70,
                      child: SizedBox(

                      height:  1,
                       width: 1,
                      child:
                          Text(discreption,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                         // ColoredBox(color: Colors.amber),
                      ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Quantity : '+dropdownValue,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Uploaded at : '+time,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Status: ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),

                          Text(donationStatus,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
                        //  Text(donationClaimer),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [

                        Container(
                          width: 200,
                         height: 45,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FlatButton(
                               color: Colors.blue[800],
                              onPressed: () {
                              locationCallBack();
                            },
                            child: Text('Check Location',style: TextStyle(color: Colors.white),
                            )
                            ),
                         ),
                        )
                      ]
                  ),
                    ],

                  ),
            )
            ),

          ],
        ),

      ),

          )
    ;
  }
}
