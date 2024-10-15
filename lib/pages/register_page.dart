import 'package:flutter/material.dart';
import 'package:space_book/components/myTextfield.dart';
import 'package:space_book/components/my_button.dart';
import 'package:space_book/components/my_loading.dart';
import 'package:space_book/services/auth/auth_service.dart';
import 'package:space_book/services/auth/database/dataBase_service.dart';

/*

REGISTER PAGE
ON THIS PAGE, A NEW USER CAN FILL OUT THE FORM AND CREATE AN ACCOUNT
THE DATA WE WILL TAKE FROM USER IS
 - NAME
 - EMAIL
 - PASSWORD
 - CONFIRM PASSWORD
--------------------------------------------------------------------

once the user successfully creates an account -> they will be redirected to 
the Home page

also if the user has an account they can go to the Login page

*/

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //access the auth & db service

  final _auth = AuthService();
  final _db = DatabaseService();
//TEXT CONTROLLERS
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  //register button

  void register() async {
    //passwords matched then create an account
    if (pwController.text == confirmController.text) {
      showLoadingCircle(context);

      //attempt to register new user
      try {
        //trying to register
        await _auth.registerEmailPassword(
            emailController.text, pwController.text);
        //finished loading

        if (mounted) hideLoadingCircle(context);
        //ONCE REGISTERED, CREATE AND SAVE USER PROFILE IN DATABASE
        await _db.saveUserInfoFirebase(
            name: namecontroller.text, email: emailController.text);
      } catch (e) {
        //finished loading

        if (mounted) hideLoadingCircle(context);
        //show user the error
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())),
          );
        }
      }
    }
    //if not matched show errors

    else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text("Passwords didn't match ")),
      );
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
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Name text field
                Mytextfield(
                  controller: namecontroller,
                  hintext: "Enter your name...",
                  obscureText: false,
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
                //confirm passswords
                const SizedBox(
                  height: 10,
                ),
                //password text field
                Mytextfield(
                  controller: confirmController,
                  hintext: "Confirm Password...",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25,
                ),
                //sign in button
                MyButton(text: "Register", onTap: register),
                const SizedBox(height: 15),
                //Already a member so u can login
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Already have an account?",
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
                        "Login now!",
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
