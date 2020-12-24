import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/wrapper.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:razzom/investor/screens/home.dart';
import 'package:razzom/investor/screens/update_profile.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/screens/no_internet.dart';
import 'package:razzom/razzom/shared/services/check_internet.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:razzom/razzom/shared/services/firebase_messaging.dart';

class Idashboard extends StatefulWidget {
  @override
  _IdashboardState createState() => _IdashboardState();
}

class _IdashboardState extends State<Idashboard> {
  void initState() {
    super.initState();
    checkInternet().checkConnection(context);
    // DatabaseService(uid: uid).getUserData();
  }

  @override
  void dispose() {
    checkInternet().listener.cancel();
    super.dispose();
  }

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
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              searchResults = false;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: internetAvailable
          ? FutureBuilder(
              future: DatabaseService(uid: uid).getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    width: MediaQuery.of(context).copyWith().size.width *
                        (100 / 100),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            // image: AssetImage(
                                            //     'assets/images/profile.png'),
                                            image: (currentUser.profilePicUrl !=
                                                    null)
                                                ? NetworkImage(
                                                    currentUser.profilePicUrl)
                                                : AssetImage(
                                                    'assets/images/profile.png'),
                                          ),
                                        ),
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
                                                  builder: (context) =>
                                                      UpdateProfile()));
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
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (85 / 100),
                                    child: Text(
                                      currentUser.name == null
                                          ? "Name"
                                          : currentUser.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
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
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (85 / 100),
                                    child: Text(
                                      currentUser.phone == null
                                          ? "Phone Number"
                                          : currentUser.phone,
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
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (85 / 100),
                                    child: Text(
                                      currentUser.email == null
                                          ? "Email"
                                          : currentUser.email,
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
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (85 / 100),
                                    child: Text(
                                      (currentUser.location['city'] == null ||
                                              currentUser.location['city'] ==
                                                  "" ||
                                              currentUser.location['country'] ==
                                                  null ||
                                              currentUser.location['country'] ==
                                                  "")
                                          ? "City, Country"
                                          : currentUser.location['city'] +
                                              ', ' +
                                              currentUser.location['country'],
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
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (85 / 100),
                                    child: Text(
                                      // 'Funding Budget: ',
                                      currentUser.funding == null
                                          ? 'Funding Required: NA'
                                          : 'Funding Required: ' +
                                              FUNDING_OPTIONS[
                                                  currentUser.funding],
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
                                    (currentUser.description == null ||
                                            currentUser.description == "")
                                        ? 'Write a short introduction.'
                                        : currentUser.description,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            // MessagingWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Loader(),
                  );
                }
              },
            )
          : NoInternet(notifyParent: refresh),
      //
    );
  }

  refresh() {
    setState(() {});
  }
}
