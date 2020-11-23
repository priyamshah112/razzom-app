import 'package:flutter/material.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/entrepreneur/screens/drawer.dart';
import 'package:razzom/entrepreneur/screens/drawer2.dart';
import 'package:razzom/entrepreneur/screens/update_profile.dart';
import 'package:razzom/entrepreneur/screens/upload_video.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/services/database.dart';

class Edashboard extends StatefulWidget {
  @override
  _EdashboardState createState() => _EdashboardState();
}

class _EdashboardState extends State<Edashboard> {
  void initState() {
    super.initState();
    // DatabaseService(uid: uid).getUserData();
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
          // IconButton(
          //   icon: Icon(
          //     Icons.home,
          //     color: Colors.white,
          //     size: 40,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Home()));
          //   },
          // ),
          // SizedBox(
          //   width: 10,
          // ),
        ],
      ),
      drawer: FutureBuilder(
          future: DatabaseService(uid: uid).getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (currentUser.videoId != null) {
                return CustomDrawer();
              } else {
                fromEdashboard = true;
                return CustomDrawer2();
              }
            } else {
              return CustomDrawer();
            }
          }),
      body: FutureBuilder(
        future: DatabaseService(uid: uid).getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // print("videoId: " + currentUser.videoId.toString());
            if (currentUser.videoId == null) {
              // if (false) {
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => UploadVideo()),
              //     (Route<dynamic> route) => false);
              // return UploadVideo();
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    (85 / 100),
                            child: Text(
                              "Upload your Pitch Video to get started!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: true,
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              color: Color(0xFF0CE5DF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(
                                  color: Color(0xFF0CE5DF),
                                ),
                              ),
                              child: Text(
                                'Upload Video',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadVideo()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
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
                                  currentUser.name,
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
                                  currentUser.phone,
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
                                  currentUser.email,
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
                                  currentUser.location['city'] +
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
                                  'Funding Required: ' +
                                      FUNDING_OPTIONS[currentUser.funding],
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        //   child: ConstrainedBox(
                        //     constraints: new BoxConstraints(
                        //       minWidth: MediaQuery.of(context).size.width,
                        //       minHeight: 150.0,
                        //     ),
                        //     child: Container(
                        //       padding: const EdgeInsets.all(15),
                        //       color: Color(0xFF0C1A24),
                        //       child: Text(
                        //         currentUser.description == ""
                        //             ? 'Write a short introduction.'
                        //             : currentUser.description,
                        //         style:
                        //             TextStyle(color: Colors.white, fontSize: 15),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Loader(),
            );
          }
        },
      ),
      //
    );
  }
}
