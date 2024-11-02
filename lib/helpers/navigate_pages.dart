//go to user page

import 'package:flutter/material.dart';
import 'package:space_book/models/post_Models.dart';
import 'package:space_book/pages/post_pages.dart';
import 'package:space_book/pages/profile_page.dart';

//navigate to the pages
void goUserPage(BuildContext context, String uid) {
  //navigate to the page
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfilePage(uid: uid)));
}
// go to the post page

void goPostPage(BuildContext context, Post post) {
  //navigate to the page
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPages(post: post),
      ));
}
