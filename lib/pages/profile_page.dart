import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

//build ui
  @override
  Widget build(BuildContext context) {
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
          //profile stats-> number of post, followers, following
          //follow/unfollow
          //bio box

          //list of post from user
        ],
      ),
    );
  }
}
