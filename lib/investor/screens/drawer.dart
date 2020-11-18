import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/authentication/signin.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/investor/screens/bookmarks.dart';
import 'package:razzom/investor/screens/connections.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/investor/screens/settings.dart';

class CustomDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF0C1A24),
        child: ListView(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.all(10),
            //   color: Color(0xFF0C1A24),
            //   child: new ListTile(
            //     leading: Icon(
            //       Icons.person,
            //       color: Colors.white,
            //       size: 30,
            //     ),
            //     title: Text(
            //       'Dashboard',
            //       style: TextStyle(color: Colors.white, fontSize: 20),
            //     ),
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => Idashboard()));
            //     },
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xFF0C1A24),
              child: new ListTile(
                leading: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Bookmarks',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Bookmarks()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: new ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Connections',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connections()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xFF0C1A24),
              child: new ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xFF0C1A24),
              child: new ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () async {
                  await _auth.signOut();
                  // await _auth.signOut().then((res) {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SignIn()),
                  //   );
                  // });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
