import 'package:flutter/material.dart';

/*
Text Field
A BOX WHERE USER CAN CAN TYPE INTO

-----------------------------------------------

TO USE THIS WIDGET, YOU NEED
 - TEXT EDITING CONTROLLER (TO ACCCESS WHAT THE USER TYPED )
 - HINT TEXT (E.G "Enter Passwords")
 - OBSURE TEXT (E.G TRUE -> HIDES PASS**********)
 */
class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final bool obscureText;

  const Mytextfield({
    super.key,
    required this.controller,
    required this.hintext,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          //BORDER WHEN UNSELECTED
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          //BORDER WHEN SELECTED

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintext,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          )),
    );
  }
}
