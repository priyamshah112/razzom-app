import 'package:cloud_firestore/cloud_firestore.dart';
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
    bool userExistsInDb = await checkUserInDb(email);
    if (userExistsInDb) {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        loading = false;
        print("user data received");
        if (result.user.emailVerified) {
          print("Email verified");
          uid = result.user.uid;
          currentUser.email = email;
          await DatabaseService(uid: uid).updateLastLogin();
          return result.user;
        } else {
          return "email not verified";
        }
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        return null;
      }
    } else {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(CustomUser user) async {
    bool userExistsInDb = await checkUserInDb(user.email);
    if (userExistsInDb) {
      return "registered";
    }
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
        return "registration successful";
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
        return null;
      }
      // await signOut();
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
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
    print("google user data " + googleUser.email);

    bool userExistsInDb = await checkUserInDb(googleUser.email);

    if (userExistsInDb) {
      // Obtain the auth details from the request
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        print(googleAuth.toString());

        // Create a new credential
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // print(credential.toString());
        var userCredential;
        // Once signed in, return the UserCredential
        try {
          userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          print(userCredential.toString());
          // print("email: " + userCredential.user.email);
        } on FirebaseAuthException catch (e) {
          print('Failed with error code: ${e.code}');
          print(e.message);
        }
        if (userCredential.user.emailVerified) {
          print("Email verified");
          uid = userCredential.user.uid;
          currentUser.email = googleUser.email;
          googleSignIn = true;
          await DatabaseService(uid: uid).updateLastLogin();
          return userCredential;
        } else {
          GoogleSignIn().signOut();
          return null;
        }
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    } else {
      return null;
    }
  }

  // logout
  Future signOut() async {
    try {
      print("reached sign out");
      if (googleSignIn) {
        googleSignIn = false;
        return await GoogleSignIn().signOut();
      } else {
        return await _auth.signOut();
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future checkUserInDb(String email) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    var user = await userCollection
        .where('email', isEqualTo: email)
        .where('is_deleted', isEqualTo: false)
        .get();
    if (user.docs.length == 0) {
      return false;
    } else {
      return true;
    }
  }
}
