import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/investor/screens/videoCard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    // DatabaseService(uid: uid).getVideos();
  }

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
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Idashboard()));
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
          future: DatabaseService(uid: uid).getVideos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (100 / 100),
                        height: 50,
                        alignment: Alignment.center,
                        color: Color(0xFF162F42),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              child: Image.asset('assets/images/coins.png'),
                              onTap: showBuyConnects,
                            ),
                            SizedBox(
                              width: 0,
                            ),
                            Text(
                              currentUser.connects.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 90,
                      child: Container(
                        color: Color(0xFF0C1A24),
                        width: MediaQuery.of(context).copyWith().size.width *
                            (100 / 100),
                        // height: MediaQuery.of(context).copyWith().size.height *
                        //         (100 / 100) -
                        //     169,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          // child: Text(
                          //   "CONNECTIONS",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 18,
                          //   ),
                          // ),
                          child: (videos.length == 0)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'No videos yet!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: videos.length,
                                  itemBuilder: (context, i) {
                                    return VideoCard(index: i);
                                    // return Text('i');
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: Color(0xFF0C1A24),
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
                // height: MediaQuery.of(context).copyWith().size.height *
                //         (100 / 100) -
                //     169,
                child: Loader(),
              );
            }
          }),
    );
  }

  showBuyConnects() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          title: Text(
            "Want more connect coins?",
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
          content: Container(
            height: 320,
            child: Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: RaisedButton(
                        color: Color(0xFF0CE5DF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: Color(0xFF0CE5DF),
                          ),
                        ),
                        child: Text(
                          '1 Connect - \$10',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          print("1 connect");
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: RaisedButton(
                        color: Color(0xFF0CE5DF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: Color(0xFF0CE5DF),
                          ),
                        ),
                        child: Text(
                          '5 Connects- \$50',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          print("5 connect");
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: RaisedButton(
                        color: Color(0xFF0CE5DF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: Color(0xFF0CE5DF),
                          ),
                        ),
                        child: Text(
                          '10 Connects - \$95',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          print("10 connect");
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/coins2.png',
                      width: 150,
                      height: 150,
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
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
  }
}
