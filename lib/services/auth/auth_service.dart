import 'package:firebase_auth/firebase_auth.dart';
/*
AUTHENTICATION SERVICE

THIS HANDLES EVRYTING RELETED TO AUTENTICATION IN FIREBASE

------------------------------------------------------------

 - LOGIN
 - REGISTER
 - LOGOUT
 - DELETE ACCOUNT (PLAYSTORE REQUIRMENTS)


*/

class AuthService {
  //GET INSTANCE OF AUTH
  final _auth = FirebaseAuth.instance;

  //GET CURRENT USER & UID
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUid() => _auth.currentUser!.uid;

  //LOGIN -> EMAIL & PW
  Future<UserCredential> loginEmailPassword(String email, password) async {
    //ATTEMPT LOGIN
    try {
      final UserCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserCredential;
    }
    //catch any errors........
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //REGISTER -> EMAIL & PW
  Future<UserCredential> registerEmailPassword(String email, password) async {
//ATTEMPT TO REGISTER
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    }
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
  //DELETE ACCOUNT
}
