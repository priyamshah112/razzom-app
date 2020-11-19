import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/authentication/register.dart';
import 'package:razzom/accounts/screens/authentication/signin.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn || fromRegister) {
      print("signin");
      return Container(
        child: SignIn(toggleView: toggleView),
      );
    } else {
      print("register");
      return Container(
        child: Register(toggleView: toggleView),
      );
    }
  }
}
