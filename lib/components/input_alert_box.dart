import 'package:flutter/material.dart';

/*

input alert box

this i an alert dialogue box that has a text field that a user can type in....
will use this things for editing bio, posting a new masssge etc
---------------------------------------------------------------------------------
to use this widget 
 - text controller
 - hint text
 - a function( saveBio() )
 - text for buttons ("save")

*/
class MyinputalertBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintext;
  final void Function()? onpressed;
  final String onpressedText;

  const MyinputalertBox({
    super.key,
    required this.textController,
    required this.hintext,
    required this.onpressed,
    required this.onpressedText,
  });
  //build ui
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,

      //text field user type here
      content: TextField(
        controller: textController,

        //limit the max characters
        maxLength: 140,
        maxLines: 3,

        decoration: InputDecoration(
          //border when the text field is unselected
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          //border when the text field is selecetd

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),

          //hintext
          hintText: hintext,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),

          //color inside the textfield
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,

          //counter 0/140
          counterStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),

//buttons
      actions: [
        //cancel button
        TextButton(
            onPressed: () {
              //pop the box
              Navigator.pop(context);

              //clear the controller
              textController.clear();
            },
            child: Text("cancel")),

        //yes button
        TextButton(
            onPressed: () {
              //close box
              Navigator.pop(context);
              //execute function
              onpressed!();
              //clear controller
              textController.clear();
            },
            child: Text(onpressedText)),
      ],
    );
  }
}
