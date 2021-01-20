import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/authentication/authentication.dart';
import 'package:razzom/accounts/screens/authentication/signin.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/entrepreneur/screens/videoPitch.dart';
import 'package:razzom/entrepreneur/screens/connections.dart';
import 'package:razzom/entrepreneur/screens/settings.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

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
                  Icons.videocam,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Video Pitch',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VideoPitch()));
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
                onTap: () {
                  // await _auth.signOut();
                  // void _showDialog() {
                  // flutter defined function
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text(
                          "Confirm Logout",
                          textAlign: TextAlign.center,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Color(0xFF162F42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        content: new Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () async {
                              // await _auth.signOut();
                              await _auth.signOut().then((res) {
                                showSignIn = true;
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Authentication()),
                                    (Route<dynamic> route) => false);
                              });
                            },
                          ),
                          new FlatButton(
                            child: new Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // }
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
