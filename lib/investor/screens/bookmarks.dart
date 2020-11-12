import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
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
            label: Text(''),
            onPressed: () {
              print("HOME");
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
              height: 50,
              alignment: Alignment.center,
              color: Color(0xFF162F42),
              child: Text(
                'Bookmarks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              color: Color(0xFF0C1A24),
              width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
              height:
                  MediaQuery.of(context).copyWith().size.height * (100 / 100) -
                      169,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Color(0xFF162F42),
                      child: Column(
                        children: <Widget>[
                          CustomVideoPlayer(
                            videoPlayerController: VideoPlayerController.network(
                                'https://firebasestorage.googleapis.com/v0/b/razzom-dev.appspot.com/o/pitch_videos%2FNrKSoxrqioYtbES4OFhYw0X55ps1?alt=media&token=d687b177-3b9b-423b-b578-593df0023c4e'),
                            looping: true,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      40 /
                                      100,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Title of the video',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      5 /
                                      100,
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.bookmark,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      35 /
                                      100,
                                  child: Column(
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Color(0xFF0CE5DF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
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
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
