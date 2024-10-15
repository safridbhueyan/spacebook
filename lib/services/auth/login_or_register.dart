import 'package:flutter/material.dart';
import 'package:space_book/pages/login_Page.dart';
import 'package:space_book/pages/register_page.dart';

/*
LOGIN OR REGISTER PAGE

THIS DETERMINES WHETER TO SHOW LOGIN PAGE OR REGISTER PAGE



 */
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
//INITIALLY , SHOW THE LOGIN PAGE

  bool showLoginPage = true;

//VOID FUNCTION TO TOGGLE BETWEEN LOGIN AND REGISTER PAGES

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

//BUILD UI
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
