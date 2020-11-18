import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/bookmarks.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/investor/screens/home.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatelessWidget {
  final int index;
  var video;

  VideoCard({this.index});

  @override
  Widget build(BuildContext context) {
    video = videos[index];
    print(video);
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Card(
            color: Color(0xFF162F42),
            child: Column(
              children: <Widget>[
                (video['url'] != "" && video['url'] != null)
                    ? CustomVideoPlayer(
                        videoPlayerController:
                            VideoPlayerController.network(video['url']),
                        looping: true,
                      )
                    : Container(
                        width: MediaQuery.of(context).copyWith().size.width,
                        height: 200,
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
                                video['title'],
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
                                  Icons.bookmark_outline_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onTap: () async {
                                  // await unbookmark();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
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
                                onPressed: () {},
                              ),
                            ],
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

  // unbookmark() async {
  //   var id = bookmark.id;
  //   print(id);
  //   await DatabaseService(uid: uid).deleteBookmark(id);
  //   dynamic result = await DatabaseService(uid: uid).getUserData();
  // }
}
