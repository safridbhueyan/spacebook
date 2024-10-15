import 'package:flutter/material.dart';

/*
              Drawer tile
 this is for the each tile in the menu drawer
*/

class MydrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const MydrawerTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
//build UI
  @override
  Widget build(BuildContext context) {
    //list tile
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      onTap: onTap,
    );
  }
}
