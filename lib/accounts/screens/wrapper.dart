import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razzom/accounts/screens/authentication/authentication.dart';
// import 'package:razzom/accounts/screens/home/home.dart';
import 'package:razzom/accounts/screens/home/info1.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return home or auth
    if (user == null) {
      if (showInfoScreens) {
        return Info1();
      } else {
        print(user);
        print("reached authentication display");
        return Authentication();
      }
    } else {
      showInfoScreens = false;
      if (user.emailVerified) {
        // loading = true;
        uid = user.uid;
        // getUserData().then(() {
        //   loading = false;
        //   return Idashboard();
        // });
        print("Investor");
        return Idashboard();
      } else {
        showSignIn = true;
        print("Email not verified");
        return Authentication();
      }
    }
  }

  getUserData() async {
    await DatabaseService(uid: uid).getData();
  }
}
