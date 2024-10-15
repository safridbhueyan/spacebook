import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_book/firebase_options.dart';
import 'package:space_book/services/auth/auth_gate.dart';
import 'package:space_book/services/auth/database/database_provider.dart';
// import 'package:space_book/pages/homePage.dart';
// import 'package:space_book/pages/login_Page.dart';
// import 'package:space_book/pages/register_page.dart';
// import 'package:space_book/services/auth/login_or_register.dart';
import 'package:space_book/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      //theme provider
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),

      //database provider
      ChangeNotifierProvider(
        create: (context) => DatabaseProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const Homepage(),
      // home: LoginPage(),
      // home: RegisterPage(),
      // home: const LoginOrRegister(),
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
