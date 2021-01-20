import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razzom/accounts/screens/authentication/authentication.dart';
// import 'package:razzom/accounts/screens/home/home.dart';
import 'package:razzom/accounts/screens/home/info1.dart';
import 'package:razzom/entrepreneur/screens/edashboard.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("wrapper");
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
      // if (user.emailVerified) {
      // loading = true;
      uid = user.uid;
      print("wrapper uid is " + uid);
      return FutureBuilder(
          future: DatabaseService(uid: uid).getInitialData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (currentUser.userType == "Investor") {
                return Idashboard();
              } else {
                print("returned Edashboard");
                return Edashboard();
              }
            } else {
              return Container(
                color: Color(0xFF0C1A24),
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
                child: Loader(),
              );
            }
          });
      // getUserData().then(() {
      //   loading = false;
      //   return Idashboard();
      // });
      // print("Investor");
      // return Idashboard();
      // } else {
      //   showSignIn = true;
      //   print("Email not verified");
      //   return Authentication();
      // }
    }
  }

  // getUserData() async {
  //   await DatabaseService(uid: uid).getData();
  // }
}
