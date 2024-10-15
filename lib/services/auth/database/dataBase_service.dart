/*

DATABASE SERVICE

this class handles all the data from and to firebase

-----------------------------------------------------------

 - user profile
 - post massge
 - likes
 - comments
 - accounts stuff( report/ block/ delete account)
 - follow/unfollow
 - search users

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_book/models/user.dart';
// import 'package:space_book/services/auth/auth_service.dart';

class DatabaseService {
//get instance of firestore db & auth

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
/*
USER PROFILE

WHEN A NEW USER REGISTER, WE CREATE AN ACCOUNT FOR THEM, BUT ALSO STORE
THEIR DETAILS IN DATABASE TO DISPLAY ON THEIR PROFILE PAGE
*/
//SAVE THE USER INFO
  Future<void> saveUserInfoFirebase(
      {required String name, required String email}) async {
//GET CURRENT UID
    String uid = _auth.currentUser!.uid;
//EXTRACT USER NAME FROM EMAIL
    String username = email.split('@')[0];

//CREATE A USER PROFILE
    UserProfile user = UserProfile(
        bio: '', email: email, name: name, uid: uid, username: username);
//CONVERT USER INTO A MAP SO THAT WE CAN STORE IN FIREBASE
    final UserMap = user.toMap();
//SAVE USER INFO IN FIREBASE
    await _db.collection("Users").doc(uid).set(UserMap);
  }

//GET THE USER INFO
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      //retrieve user doc from firebase
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();

      //convert doc to user profile
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
