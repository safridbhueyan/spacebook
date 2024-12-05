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
import 'package:provider/provider.dart';
// import 'package:space_book/helpers/navigate_pages.dart';
import 'package:space_book/models/post_Models.dart';
import 'package:space_book/services/auth/auth_service.dart';
import 'package:space_book/services/auth/database/database_provider.dart';

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
  //provider
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  //likes

  //user tapped like (or unlike)
  void _toggleLikePost() async {
    try {
      await databaseProvider.togglelike(widget.post.id);
    } catch (e) {
      print(e);
    }
  }

//show options for post
  void _showOption() {
    //check if this post is owned by the user or not
    String currentUid = AuthService().getCurrentUid();

    final bool isOwnPost = widget.post.uid == currentUid;

    // Create a list for user-specific options
    List<Widget> options = isOwnPost
        ? [
            // Delete option if it's the user's own post
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () async {
                //pop the option box
                Navigator.pop(context);

                //do the delete action

                await databaseProvider.deletePost(widget.post.id);
              },
            ),
          ]
        : [
            // Report and Block options if it's someone else's post
            ListTile(
              leading: Icon(Icons.flag),
              title: Text("Report"),
              onTap: () {
                //pop the option box
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text("Block User"),
              onTap: () {
                //pop the option box
                Navigator.pop(context);
              },
            ),
          ];

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                //delete message button
                ...options,

                // cancel button

                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text("Cancel"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //does the current user like the post?
    bool likedBycurrentUser =
        listeningProvider.isPostLikedByCurrentUser(widget.post.id);
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

                  Spacer(),
                  //buttons -> more options: delete
                  GestureDetector(
                      onTap: _showOption,
                      child: Icon(
                        Icons.more_horiz,
                        color: Theme.of(context).colorScheme.primary,
                      ))
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
            const SizedBox(
              height: 20,
            ),
            //buttons -> like + comments
            Row(
              children: [
                //liked button
                GestureDetector(
                  onTap: _toggleLikePost,
                  child: likedBycurrentUser
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border,
                          color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
