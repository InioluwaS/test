import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:greatdanic_logistics/models/user.dart';

class AuthServices with ChangeNotifier{
  final _auth = FirebaseAuth.instance;

  //Create User Object based on firebase user
  UserEntry _userFromFirebaseUser(User user) {
    return user != null ? UserEntry(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserEntry> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Sign In with Email and Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Signing out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
