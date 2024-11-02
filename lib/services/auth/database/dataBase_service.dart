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
import 'package:space_book/models/post_Models.dart';
import 'package:space_book/models/user.dart';
import 'package:space_book/services/auth/auth_service.dart';
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

//update the user bio
  Future<void> updateUserBioInFirebase(String bio) async {
    //get current uid
    String uid = AuthService().getCurrentUid();
    //attempt to update in firebase
    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

//POST

//post a message
  Future<void> postMessageInFirebase(String message) async {
    try {
      //get current user id
      String uid = _auth.currentUser!.uid;
      //use this uid to get the users profile
      UserProfile? user = await getUserFromFirebase(uid);

      //create a new post

      Post newPost = Post(
        id: '', //firebase auto generate this
        uid: uid,
        name: user!.name,
        username: user.username,
        message: message,
        likeCount: 0,
        likedBy: [],
        timestamp: Timestamp.now(),
      );

      //convert this post object to map
      Map<String, dynamic> newPostMap = newPost.toMap();

      //add  map to fire store
      await _db.collection("Posts").add(newPostMap);
    } catch (e) {
      print(e);
    }
  }

//Delete a post
//get all the post from firebase

  Future<List<Post>> getAllPostFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          //go to collection -> posts
          .collection("Posts")
          //chronological order
          .orderBy('timestamp', descending: true)
          //get this data
          .get();

      //return as a list of post
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e) {
      return [];
    }
  }
//get individual post
}
