import 'package:flutter/material.dart';
import 'package:neamah/components/GoogleMap.dart';
import 'package:neamah/components/Location.dart';

/*

this button is to open googlemap page, with user location

 */

class setLocationButton extends StatelessWidget {
  static var address;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 200,
          height: 45,

      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlatButton(
                    color: Colors.blue[800],

              onPressed: () async {
                  // await Location
                  //     .getLocation();

                var loc = await Location.getLocation();

                address = await Navigator.push(
                            context,
                MaterialPageRoute(builder: (context) {
                    return map(loc);
              }
            ),
          );
            },
          child:
          Text('Setup Location',style: TextStyle(color: Colors.white)),
        ),
            ),
        );
      }
    }

/* return ElevatedButton(
      onPressed: () async {
        // await Location
        //     .getLocation();

        var loc = await Location.getLocation();

        address = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return map(loc);
          }),
        );
      },
      child: Text('Set up location'),
    );
  }
}

    */