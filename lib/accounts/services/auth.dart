import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:razzom/razzom/models/customUser.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

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
      loading = false;
      print("user data received");
      if (result.user.emailVerified) {
        print("Email verified");
        uid = result.user.uid;
        return result.user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(CustomUser user) async {
    try {
      print("reached registration");
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await DatabaseService(uid: result.user.uid).createUserData(user);
      print("back from db");
      loading = false;
      try {
        await result.user.sendEmailVerification();
        print(result.user.uid);
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      }
      // await signOut();
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
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

  // google sign in
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print(googleAuth.toString());

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // print(credential.toString());

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // logout
  Future signOut() async {
    try {
      print("reached sign out");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
