/*
post page

this page displays:

- individual posts
- comments on this posts


*/

import 'package:flutter/material.dart';
import 'package:space_book/components/my_post_tile.dart';
import 'package:space_book/helpers/navigate_pages.dart';
import 'package:space_book/models/post_Models.dart';

class PostPages extends StatefulWidget {
  final Post post;

  PostPages({super.key, required this.post});

  @override
  State<PostPages> createState() => _PostPagesState();
}

class _PostPagesState extends State<PostPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //post
          MyPostTile(
              post: widget.post,
              onUSerTap: () => goUserPage(context, widget.post.uid),
              onPostTap: () {}),
          //comments on that post
        ],
      ),
    );
  }
}
