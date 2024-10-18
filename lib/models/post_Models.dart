/*
POST MODEL

THIS IS WHAT EVERY POST SHOULD HAVE 

*/

import 'package:cloud_firestore/cloud_firestore.dart';

class post {
  final String id; //id of the post
  final String uid; //user id of poster
  final String name; // name of the poster
  final String username; //username of poster
  final String message; // message of the post
  final Timestamp timestamp; //timeStamp of the post
  int likeCount; //like count of the post
  final List<String> likedBy; //list of User IDs that the post were liked by
  post({
    required this.id,
    required this.uid,
    required this.name,
    required this.username,
    required this.message,
    required this.likeCount,
    required this.likedBy,
    required this.timestamp,
  });
  //convert a firestore document to a post object (to use it in our app)
  factory post.fromDocument(DocumentSnapshot doc) {
    return post(
      id: doc.id,
      uid: doc['uid'],
      name: doc['name'],
      username: doc['username'],
      message: doc['message'],
      likeCount: doc['likes'],
      likedBy: List<String>.from(doc['likedBy'] ?? []),
      timestamp: doc['timestamp'],
    );
  }

  //convert a post object to a map (to store in firebase)

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'message': message,
      'timestamp': timestamp,
      'likes': likeCount,
      'likedBy': likedBy,
    };
  }
}
