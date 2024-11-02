/*
POST TILE

ALL POST WILL BE DISPLAYED USING THIS POST TILE WIDGET

--------------------------------------------------------------
TO USE THIS WIDGET , WE NEED 
-THE POST
- a function onPostTap (go to the individual post to see its comments )
- a function for onUserTap (go to users profile page )
*/

import 'package:flutter/material.dart';
// import 'package:space_book/helpers/navigate_pages.dart';
import 'package:space_book/models/post_Models.dart';

class MyPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUSerTap;
  final void Function()? onPostTap;
  const MyPostTile({
    super.key,
    required this.post,
    required this.onUSerTap,
    required this.onPostTap,
  });

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        //padding outside
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),

        //padding inside
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          //color of post tile
          color: Theme.of(context).colorScheme.secondary,
          //curve corners
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top section -> profile pic,/name/username
            GestureDetector(
              onTap: widget.onUSerTap,
              child: Row(
                children: [
                  //profile pic
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  //name
                  Text(
                    widget.post.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //user handle
                  Text(
                    '@${widget.post.username}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //message
            Text(
              widget.post.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
