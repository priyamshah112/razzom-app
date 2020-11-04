import 'package:firebase_auth/firebase_auth.dart';
import 'package:razzom/accounts/models/customUser.dart';
import 'package:razzom/accounts/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  // ignore: deprecated_member_use
  Stream<User> get user {
    // ignore: deprecated_member_use
    return _auth.authStateChanges();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(CustomUser user) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await DatabaseService(uid: result.user.uid).createUserData(user);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
