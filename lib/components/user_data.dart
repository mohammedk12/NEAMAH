import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? activeUser;

/*

user provider

notice in every method, first we edit the user provider list,
then we edit 'users' in fire base

you want to read or write something related to users?
you should use one of the methods here

 */

class user_data {
  static String getCurrentUserEmail() {
    String email = '';
    try {
      final user = _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        email = activeUser!.email!;
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }

    return email;
  }

  static Future<String> getCurrentUserID() async {
    late String id;
    try {
      final user = _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        var data = await _firestore
            .collection('users')
            .doc('${activeUser!.uid}')
            .get();
        id = data.data()!['id'];
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }

    return id;
  }

  static Future<int> getCurrentUserScore() async {
    late int score;
    try {
      final user = _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        var data = await _firestore
            .collection('users')
            .doc('${activeUser!.uid}')
            .get();
        score = data.data()!['score'];
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }

    return score;
  }

  static Future<String> getCurrentUserPhone() async {
    late String phone;
    try {
      final user = _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        var data = await _firestore
            .collection('users')
            .doc('${activeUser!.uid}')
            .get();

        phone = data.data()!['phone'];
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }

    return phone;
  }

  static Future<int> getCurrentUserType() async {
    late int type;
    try {
      final user = _auth.currentUser;
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        var data = await _firestore
            .collection('users')
            .doc('${activeUser!.uid}')
            .get();
        type = data.data()!['DonnerOrPIN'];
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }

    print('ahla::::::  $type');
    return type;
  }

  static Future<String> getCurrentUserClaimedDON_id() async {
    late String id;
    try {
      final user = await _auth.currentUser;
      print(user!.email);
      // user will be null if the user is not logged in

      if (user != null) {
        activeUser = user;
        var data = await _firestore
            .collection('users')
            .doc('${activeUser!.uid}')
            .get();
        id = data.data()!['claimed_don'];
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }
    return id;
  }

  static Future<void> setCurrentUserClaimedDON_id(String claimed_id) async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        activeUser = user;
        await _firestore.collection('users').doc('${user.uid}').update({
          'claimed_don': claimed_id,
        });
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateScore() async {
    try {
      final user = _auth.currentUser;

      int score = await getCurrentUserScore();
      int new_score = score + 50;

      if (user != null) {
        activeUser = user;
        await _firestore.collection('users').doc('${user.uid}').update({
          'score': new_score,
        });
      } else {
        print('nulllllllllll');
      }
    } catch (e) {
      print(e);
    }
  }
}
