/*

DATABASE PROVIDER

This provider is to seperate firestore data handling and ui ofour app

 - The database service class handles data to and from firebase
 - The database provider class proccesess the data to  display in our app
 - this is to make our app moduler clean easier to read
 - if we want to switch our database we can do it easily (from firebase to something else)


*/

import 'package:flutter/material.dart';
import 'package:space_book/models/post_Models.dart';
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

  //update the user bio
  Future<void> updateBio(String bio) => _db.updateUserBioInFirebase(bio);

  //post

  //local lists of posts

  List<Post> _allPosts = [];

  //get posts
  List<Post> get allPosts => _allPosts;

  //post message
  Future<void> postMessage(String message) async {
    //post massge in firebase
    await _db.postMessageInFirebase(message);
    //reload data from firebase
    await loadAllPosts();
  }

  //fetch all post
  Future<void> loadAllPosts() async {
    final allposts = await _db.getAllPostFromFirebase();

    //update the local data
    _allPosts = allposts;

    //initialize local like data
    initializeLikeMap();

    //update UI
    notifyListeners();
  }

//filter & return the post given UID

  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  //delete the post

  Future<void> deletePost(String postId) async {
    //delete from firebase
    await _db.deletePostFromFirebase(postId);
    //reload our data from firebase
    await loadAllPosts();
  }

  //likes
//local map to track the like count for each post
  Map<String, int> _likeCounts = {
    //for each post id : like count
  };

//local list to track posts liked by current user
  List<String> _likedposts = [];
//Does the current user liked the post?
  bool isPostLikedByCurrentUser(String postId) => _likedposts.contains(postId);
//get the like count of the post
  int getLikeCount(String postID) => _likeCounts[postID]!;
//initialize like map locally
  void initializeLikeMap() {
    //get user current Uid
    final currentUSerID = _auth.getCurrentUid();
    //for each post get like data
    for (var post in _allPosts) {
      _likeCounts[post.id] = post.likeCount;
      if (post.likedBy.contains(currentUSerID)) {
        //add this post id to local list of liked post
        _likedposts.add(post.id);
      }
    }
  }

//toggle like
  Future<void> togglelike(String postId) async {
    /* this first part will update the local value 
  so that ui feel immidiate and responsive we will update the ui optimistically
  and revert back if anything goes wrong while writing to the database
  optimistically pdating the local values like this is important because reading and
  writing from database take some time (1-2 sec )

*/
//store original values in case it fails
    final likedpostOG = _likedposts;
    final likeCountOG = _likeCounts;
//perform the like / unlike
    if (_likedposts.contains(postId)) {
      _likedposts.remove(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) - 1;
    } else {
      _likedposts.add(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) + 1;
    }
//update UI locally
    notifyListeners();
//lets update it in our database

//attempt like in database
    try {
      await _db.togglelikeInFirebase(postId);
    }

//revert back to initial state
    catch (e) {
      _likedposts = likedpostOG;
      _likeCounts = likeCountOG;

      //update UI
      notifyListeners();
    }
  }
}
