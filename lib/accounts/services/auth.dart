import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:razzom/accounts/models/customUser.dart';
import 'package:razzom/accounts/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      print("back from db");
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future signInWithGoogle() async {
  //   print('Google Sign in');
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   final User user = (await _auth.signInWithCredential(credential)).user;
  //   print(user);
  // }

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
