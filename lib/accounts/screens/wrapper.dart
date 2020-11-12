import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razzom/accounts/screens/authentication/authentication.dart';
// import 'package:razzom/accounts/screens/home/home.dart';
import 'package:razzom/accounts/screens/home/info1.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final user = Provider.of<User>(context);
    print(user);
    // return home or auth
    if (user == null) {
      if (showInfoScreens) {
        return Info1();
      } else {
        return Authentication();
      }
    } else {
      showInfoScreens = false;
      if (user.emailVerified) {
        uid = user.uid;
        print("Investor");
        return Idashboard();
      } else {
        showSignIn = true;
        print("Email not verified");
        return Authentication();
      }
    }
  }
}
