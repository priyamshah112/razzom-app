import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:video_player/video_player.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=fuFdY0-iIPc')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
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
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Center(
                                child: _controller.value.initialized
                                    ? AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: Image.asset(
                                  'assets/images/whatsapp.png',
                                  scale: 1.5,
                                ),
                                onPressed: () {/* ... */},
                              ),
                              SizedBox(width: 8),
                            ],
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
