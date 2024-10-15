import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_book/components/mySettingsTile.dart';
import 'package:space_book/themes/theme_provider.dart';

/*
SETTINGS PAGE 
 - Dark mode
 - Blocked users
 - Account settings

*/
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "S E T T I N G S",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Dark mode tile
          Mysettingstile(
            title: "Dark Mode",
            action: CupertinoSwitch(
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            ),
          ),
          // Blocked users tile

          //Accounts Settings tile
        ],
      ),
    );
  }
}
