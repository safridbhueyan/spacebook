import 'package:flutter/material.dart';
import 'package:space_book/components/myTextfield.dart';
import 'package:space_book/components/my_button.dart';
import 'package:space_book/components/my_loading.dart';
import 'package:space_book/services/auth/auth_service.dart';

/*

Login Page
on this page an existing user can log in with their:
 -email
 -password  
----------------------------------------------------

once the user succesfully logged in , theyll be redirect to the homepage
if the user doesnt have an account , they can go to the register page from here

 */

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //access the auth service
  final _auth = AuthService();

//TEXT CONTROLLERS
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
//  login method
  void login() async {
    //SHOW LOADING CIRCLE
    showLoadingCircle(context);

    //attempt to login
    try {
      await _auth.loginEmailPassword(emailController.text, pwController.text);
      //finished the loading
      if (mounted) hideLoadingCircle(context);
    }
    //catch any errors

    catch (e) {
      if (mounted) hideLoadingCircle(context);
      //let user know there was an error

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
  }

  //Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      //body or form Ui

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //Logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 50),
                //welcome back massges
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //email text field
                Mytextfield(
                  controller: emailController,
                  hintext: "Enter an email...",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                //password text field
                Mytextfield(
                  controller: pwController,
                  hintext: "Enter a Password...",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                //forgot password?
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                //sign in button
                MyButton(text: "Login", onTap: login),
                const SizedBox(height: 15),
                //not a member? register now
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
