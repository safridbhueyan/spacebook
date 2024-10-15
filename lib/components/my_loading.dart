import 'package:flutter/material.dart';
/*


LOADING CIRCLE



 */

//SHOW LOADING CIRCLE
void showLoadingCircle(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          ));
}

//hide the loading circle

void hideLoadingCircle(BuildContext context) {
  Navigator.pop(context);
}
