import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/bookmarks.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class BookmarkCard extends StatefulWidget {
  final int index;

  BookmarkCard({this.index});

  @override
  _BookmarkCardState createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  var bookmark;

  @override
  Widget build(BuildContext context) {
    bookmark = bookmarks[widget.index];
    // print(bookmark);
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Card(
            color: Color(0xFF162F42),
            child: Column(
              children: <Widget>[
                // (bookmark['video_url'] != "" && bookmark['video_url'] != null)
                // ? CustomVideoPlayer(
                //     videoPlayerController: VideoPlayerController.network(
                //         bookmark['video_url']),
                //     looping: true,
                //   )
                // :
                Container(
                  width: MediaQuery.of(context).copyWith().size.width,
                  height: 150,
                  child: Text(
                    'Cannot load video!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                bookmark['video_title'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Icon(
                                  Icons.bookmark_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onTap: () async {
                                  await unbookmark();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Bookmarks()),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true, //TO DO
                        child: Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                RaisedButton(
                                  color: Color(0xFF0CE5DF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                      color: Color(0xFF0CE5DF),
                                    ),
                                  ),
                                  child: Text(
                                    'Connect',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    if (currentUser.connects == 0) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            // titlePadding: EdgeInsets.fromLTRB(
                                            //     10, 20, 10, 0),
                                            title: Text(
                                              "Insufficient connect coins",
                                              // textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            backgroundColor: Color(0xFF162F42),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              side: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "You must purchase more connect coins in order to make this connection!",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              // FlatButton(
                                              // child:
                                              SizedBox(
                                                // width: 180,
                                                child: RaisedButton(
                                                  color: Color(0xFF0CE5DF),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    side: BorderSide(
                                                      color: Color(0xFF0CE5DF),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Buy Connects',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // await _auth.signOut();
                                                    print("BUY CONNECTS");
                                                    showBuyConnects();
                                                  },
                                                ),
                                              ),
                                              // ),
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
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            // titlePadding: EdgeInsets.fromLTRB(
                                            //     10, 20, 10, 0),
                                            title: Text(
                                              "Connect Confirmation",
                                              // textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            backgroundColor: Color(0xFF162F42),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              side: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "Are you sure you want to connect? Your connects balance will be " +
                                                  (currentUser.connects - 1)
                                                      .toString() +
                                                  " after the transaction.",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await connect();
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Bookmarks()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  "No",
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
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  unbookmark() async {
    var id = bookmark.id;
    print(id);
    await DatabaseService(uid: uid).deleteBookmark(id);
    // dynamic result = await DatabaseService(uid: uid).getUserData();
  }

  connect() async {
    print(bookmark['entrepreneur_id']);
    await DatabaseService(uid: uid)
        .createConnection(bookmark['entrepreneur_id']);
    // dynamic result = await DatabaseService(uid: uid).getUserData();
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
