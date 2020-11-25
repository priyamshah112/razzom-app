import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/bookmarkCard.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:razzom/investor/screens/home.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  void initState() {
    super.initState();
    // DatabaseService(uid: uid).getBookmarks();
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
      body: Container(
        width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
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
            ),
            Expanded(
              flex: 90,
              child: FutureBuilder(
                future: DatabaseService(uid: uid).getBookmarks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      color: Color(0xFF0C1A24),
                      width: MediaQuery.of(context).copyWith().size.width *
                          (100 / 100),
                      // height: MediaQuery.of(context).copyWith().size.height *
                      //         (100 / 100) -
                      //     169,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: (bookmarks.length == 0)
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  'No bookmarks yet!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                itemCount: bookmarks.length,
                                itemBuilder: (context, i) {
                                  return BookmarkCard(index: i);
                                },
                              ),
                      ),
                    );
                  } else {
                    return Container(
                      color: Color(0xFF0C1A24),
                      width: MediaQuery.of(context).copyWith().size.width *
                          (100 / 100),
                      // height: MediaQuery.of(context).copyWith().size.height *
                      //         (100 / 100) -
                      //     169,
                      child: Loader(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
