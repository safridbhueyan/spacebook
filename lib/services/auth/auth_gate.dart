import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:space_book/pages/homePage.dart';
import 'package:space_book/services/auth/login_or_register.dart';

/*
 AUTH GATE

 THIS IS TO CHECK IF THE USER IS LOGGED IN OR NOT

 ---------------------------------------------------------------

 IF USER IS LOGGED IN -----> WILL GO TO HOME PAGE
 IF USER IS NOT LOGGED IN -. GO TO LOGIN OR REGISTER PAGE


*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //if user is logged in
            if (snapshot.hasData) {
              return const Homepage();
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
