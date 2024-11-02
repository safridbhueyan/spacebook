import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_book/components/drawer.dart';
import 'package:space_book/components/input_alert_box.dart';
import 'package:space_book/components/my_post_tile.dart';
import 'package:space_book/helpers/navigate_pages.dart';
import 'package:space_book/models/post_Models.dart';
import 'package:space_book/services/auth/database/database_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //listening provider
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  //database provider
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
//text controller
  final _messageController = TextEditingController();
//on startup
  @override
  void initState() {
    super.initState();

    //lets load all the posts
    loadAllPosts();
  }

//load all the post
  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  //show post message dialog box
  void _openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => MyinputalertBox(
          textController: _messageController,
          hintext: "whats poppin?",
          onpressed: () async {
            //post in db
            await postMessage(_messageController.text);
          },
          onpressedText: "post"),
    );
  }

//user wants to post a massge
  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "H O M E P A G E",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Mydrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostMessageBox,
        child: Icon(Icons.add),
      ),
      body: _buildPostList(listeningProvider.allPosts),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    //post list is empty
    return posts.isEmpty
        ? Center(
            child: Text("nothing is here..."),
          )
        //post list isnt empty
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              //get each individual posts
              final post = posts[index];
              //return as post tile ui
              return MyPostTile(
                post: post,
                onUSerTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            },
          );
  }
}
