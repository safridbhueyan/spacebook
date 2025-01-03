import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_book/components/input_alert_box.dart';
import 'package:space_book/components/my_bioBox.dart';
import 'package:space_book/components/my_post_tile.dart';
import 'package:space_book/helpers/navigate_pages.dart';
import 'package:space_book/models/user.dart';
import 'package:space_book/services/auth/auth_service.dart';
import 'package:space_book/services/auth/database/database_provider.dart';

/*
PROFILE PAGE

THIS THE PROFILE PAG EFOR A GIVEN UID

-------------------------------------------------------------------


*/
class ProfilePage extends StatefulWidget {
  // user ID
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
//listening provider
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

//text controller for bio
  final bioTextController = TextEditingController();

  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
//user info

  UserProfile? user;
  String currentUserID = AuthService().getCurrentUid();
//loading
  // ignore: unused_field
  bool _isLoading = true;
//on the startup
  @override
  void initState() {
    super.initState();

    //load user info
    loadUser();
  }

  Future<void> loadUser() async {
    //get the user profile info through database provider
    user = await databaseProvider.userProfile(widget.uid);
    setState(() {
      _isLoading = false;
    });
  }

//show edit bio box
  void _showEditBioBox() {
    showDialog(
        context: context,
        builder: (context) => MyinputalertBox(
            textController: bioTextController,
            hintext: "Edit bio....",
            onpressed: saveBio,
            onpressedText: "Save"));
  }

//save the updated bio
  Future<void> saveBio() async {
    //start loading....
    setState(() {
      _isLoading = true;
    });
    //update bio
    await databaseProvider.updateBio(bioTextController.text);
    //reload user
    await loadUser();
    print("Updated bio: ${user?.bio}");
    //done loading
    setState(() {
      _isLoading = false;
    });
    print("saving....");
  }

//build ui
  @override
  Widget build(BuildContext context) {
    //get user post

    final allUserPosts = listeningProvider.filterUserPosts(widget.uid);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          _isLoading ? '' : user!.name,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //USerName handle
          Center(
            child: Text(
              _isLoading ? '' : '@${user!.username}',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //profile picture
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(25)),
              padding: EdgeInsets.all(25),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //profile stats-> number of post, followers, following
          //follow/unfollow
          //bio box
          //edit the bio
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bio",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                    onTap: _showEditBioBox,
                    child: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ],
            ),
          ),
          MyBiobox(text: _isLoading ? '.....' : user!.bio),
          Padding(
            padding: EdgeInsets.only(left: 25.0, top: 25),
            child: Text(
              "Posts",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          //list of post from user
          allUserPosts.isEmpty
              ?
              //user post is empty
              Center(
                  child: Text("No post to display...."),
                )
              :
              //user post is not empty
              ListView.builder(
                  itemCount: allUserPosts.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //get individual post
                    final post = allUserPosts[index];
                    //post tile ui
                    return MyPostTile(
                      post: post,
                      onPostTap: () => goPostPage(context, post),
                      onUSerTap: () {},
                    );
                  })
        ],
      ),
    );
  }
}
