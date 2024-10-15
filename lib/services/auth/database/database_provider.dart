/*

DATABASE PROVIDER

This provider is to seperate firestore data handling and ui ofour app

 - The database service class handles data to and from firebase
 - The database provider class proccesess the data to  display in our app
 - this is to make our app moduler clean easier to read
 - if we want to switch our database we can do it easily (from firebase to something else)


*/

import 'package:flutter/material.dart';
import 'package:space_book/models/user.dart';
import 'package:space_book/services/auth/auth_service.dart';
import 'package:space_book/services/auth/database/dataBase_service.dart';

class DatabaseProvider extends ChangeNotifier {
//services

//get db & auth service

  // ignore: unused_field
  final _auth = AuthService();
  final _db = DatabaseService();

// USER PROFILE
  //get user profile given uid
  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);
}
