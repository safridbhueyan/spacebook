import 'package:flutter/material.dart';

/*
Settings List tile
this is a simple tile for each items in the settings page
--------------------------------------------------------------------

to use this this widget u need
 - title(e.g Dark mode)
 - action(e.g toggletheme)
*/
class Mysettingstile extends StatelessWidget {
  final String title;
  final Widget action;
  const Mysettingstile({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      //padding outside
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      //padding inside
      padding: const EdgeInsets.all(25),

      //Row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          action,
        ],
      ),
    );
  }
}
