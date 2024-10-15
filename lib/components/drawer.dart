import 'package:flutter/material.dart';
import 'package:space_book/components/list_tile.dart';
import 'package:space_book/pages/profile_page.dart';
import 'package:space_book/pages/settings.dart';
import 'package:space_book/services/auth/auth_service.dart';

class Mydrawer extends StatelessWidget {
  Mydrawer({super.key});
  final _auth = AuthService();

  void logout() {
    _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              //app logo
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  )),

              //Divider line problem solved

              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(
                height: 10,
              ),
              //home list tile
              MydrawerTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {
                  //pop it up
                  Navigator.pop(context);
                },
              ),
              // profile list tile
              MydrawerTile(
                title: "P R O F I L E",
                icon: Icons.person_2,
                onTap: () {
                  //pop the menu
                  Navigator.pop(context);

                  //go to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        uid: _auth.getCurrentUid(),
                      ),
                    ),
                  );
                },
              ),
              //search list tile
              MydrawerTile(
                title: "S E A R C H",
                icon: Icons.search,
                onTap: () {},
              ),
              //settings list tile
              MydrawerTile(
                title: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  //pop and go
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ));
                },
              ),
              //logout list tile
              SizedBox(
                height: 200,
              ),
              MydrawerTile(
                title: "L O G O U T",
                icon: Icons.logout,
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
