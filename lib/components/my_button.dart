import 'package:flutter/material.dart';

/*

A  SIMPLE BUTTON

-------------------------------------------
TO USE THIS WIDGET, YOU NEED:
 - text
 - a function (on tap)

 */
class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //PADDING ON INSIDE
        padding: const EdgeInsets.all(20),

        //COLOR OF THE BUTTON
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,

          //curved the corners
          borderRadius: BorderRadius.circular(12),
        ),
        //MAKE THE CONTAINER SPREAD WIDE
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
