import 'package:flutter/material.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:razzom/investor/screens/update_profile.dart';

class Idashboard extends StatefulWidget {
  @override
  _IdashboardState createState() => _IdashboardState();
}

class _IdashboardState extends State<Idashboard> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Razzom',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Bahnschrift',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C1A24),
        actions: [
          FlatButton.icon(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
            label: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print("HOME");
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            width: 150,
                            height: 150,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateProfile()));
                            },
                            child: Image.asset(
                              'assets/images/edit.png',
                              scale: 1.2,
                              //
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (85 / 100),
                        child: Text(
                          'Husain Burhani',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (85 / 100),
                        child: Text(
                          '+44 7878182017',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (85 / 100),
                        child: Text(
                          'husain.burhani2000@gmail.com',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (85 / 100),
                        child: Text(
                          'Colchester, United Kingdom',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (85 / 100),
                        child: Text(
                          'Funding Budget: \$500,000',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: 150.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: Color(0xFF0C1A24),
                      child: Text(
                        'Write a short introduction.',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
