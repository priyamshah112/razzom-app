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
    DatabaseService(uid: uid).getVideos();
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
      body: Container(
        width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).copyWith().size.width * (100 / 100),
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
                  Image.asset('assets/images/coins.png'),
                ],
              ),
            ),
            FutureBuilder(
              future: DatabaseService(uid: uid).getVideos(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    color: Color(0xFF0C1A24),
                    width: MediaQuery.of(context).copyWith().size.width *
                        (100 / 100),
                    height: MediaQuery.of(context).copyWith().size.height *
                            (100 / 100) -
                        169,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child:
                            // (videos.length == 0)?
                            Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            'No videos yet!',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        )
                        // : ListView.builder(
                        //     itemCount: videos.length,
                        //     itemBuilder: (context, i) {
                        //       return VideoCard(index: i);
                        //       // return Text('i');
                        //     },
                        //   ),
                        ),
                  );
                } else {
                  return Container(
                    color: Color(0xFF0C1A24),
                    width: MediaQuery.of(context).copyWith().size.width *
                        (100 / 100),
                    height: MediaQuery.of(context).copyWith().size.height *
                            (100 / 100) -
                        169,
                    child: Loader(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
