/*
USER PROFILE

THIS IS WHAT EVERY USER SHOULD HAVE THEIR PROFILE


--------------------------------------------------------

 - UID
 - NAME
 - EMAIL
 - USERNAME
 - BIO
 - PROFILE PIC (OPTIONAL)


*/
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String username;
  final String bio;

  UserProfile({
    required this.bio,
    required this.email,
    required this.name,
    required this.uid,
    required this.username,
  });
//firebase -> app
//convert firestore document to a user (so that we can use it our app)
  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile(
      bio: doc['bio'],
      email: doc['email'],
      name: doc['name'],
      uid: doc['uid'],
      username: doc['username'],
    );
  }
//app -> firebase
//convert a user profile to a Map (so that we can store it in firbase)

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'username': username,
      'bio': bio,
    };
  }
}
