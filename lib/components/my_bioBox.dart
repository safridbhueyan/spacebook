import 'package:flutter/material.dart';

/*
USER BIO BOX

this is a simple box with text inside. we will use this for user bio on their profile pages
--------------------------------------------------------------------------------------------
TO USE THIS WIDGET , YOU JUST NEED
 - TEXT
*/
class MyBiobox extends StatelessWidget {
  final String text;
  const MyBiobox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
//padding inside
      padding: EdgeInsets.all(25),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
