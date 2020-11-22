import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razzom/entrepreneur/screens/customVideoPlayer.dart';
import 'package:razzom/entrepreneur/screens/drawer.dart';
import 'package:razzom/entrepreneur/screens/edashboard.dart';
import 'package:razzom/entrepreneur/screens/upload_video.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class VideoPitch extends StatefulWidget {
  @override
  _VideoPitchState createState() => _VideoPitchState();
}

class _VideoPitchState extends State<VideoPitch> {
  bool videoRejected = false;
  bool videoPending = false;
  String videoApprovalStatus = "";

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
                  MaterialPageRoute(builder: (context) => Edashboard()));
            },
          ),
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
                // height: 50,
                alignment: Alignment.center,
                color: Color(0xFF162F42),
                child: Text(
                  'Video Pitch',
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
                future: DatabaseService(uid: uid).getPitchVideo(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    videoApprovalStatus = pitchVideo['approval_status'];
                    if (videoApprovalStatus == "R") {
                      videoRejected = true;
                    }
                    if (videoApprovalStatus == "P") {
                      videoPending = true;
                    }
                    return Container(
                      color: Color(0xFF0C1A24),
                      width: MediaQuery.of(context).copyWith().size.width *
                          (100 / 100),
                      // height: MediaQuery.of(context).copyWith().size.height *
                      //         (100 / 100) -
                      //     169,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                // width: MediaQuery.of(context)
                                //         .copyWith()
                                //         .size
                                //         .width *
                                //     0.9,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .width *
                                          0.7,
                                      child: Text(
                                        // 'Video Title jhbhbjh bjbh jh bjhb jhb jhb ',
                                        pitchVideo['title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   'Video',
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  (pitchVideo['url'] != "" &&
                                          pitchVideo['url'] != null)
                                      ? CustomVideoPlayer(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  pitchVideo['url']),
                                          looping: true,
                                        )
                                      : Center(
                                          child: Container(
                                            color: Colors.grey,
                                            width: MediaQuery.of(context)
                                                    .copyWith()
                                                    .size
                                                    .width *
                                                0.8,
                                            height: 200,
                                            child: Center(
                                              child: Text(
                                                'Cannot load video!',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  // Center(
                                  //   child: Container(
                                  //     color: Colors.grey,
                                  //     width: MediaQuery.of(context)
                                  //             .copyWith()
                                  //             .size
                                  //             .width *
                                  //         0.8,
                                  //     height: 200,
                                  //     child: Center(
                                  //       child: Text(
                                  //         'Cannot load video!',
                                  //         style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontSize: 18,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Visibility(
                                visible: !videoPending,
                                child: SizedBox(
                                  height: 25,
                                ),
                              ),
                              Visibility(
                                visible: !videoPending,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                        'Edit',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadVideo()));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Video Status:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //      {% if video_info.approval_status == "P" %}
                                  // <h4 id="P" class="videoStatus">Video Review Status: <span data-toggle="tooltip" title="Your video is under review" data-placement="top">Pending</span></h4>
                                  // {% elif video_info.approval_status == "A" %}
                                  // <h4 id="A" class="videoStatus">Video Review Status: <span data-toggle="tooltip" title="Your video is live to all investors on the platform" data-placement="top">Approved</span></h4>
                                  // {% elif video_info.approval_status == "R" %}
                                  // <h4 id="R" class="videoStatus">Video Review Status: <span data-toggle="tooltip" title="Your video was rejected as there was some issue. Please follow the instructions and upload again." data-placement="top">Rejected</span></h4>
                                  // {% endif %}
                                  Tooltip(
                                    message: (videoApprovalStatus == "A")
                                        ? "Your video is live to all investors on the platform"
                                        : ((videoApprovalStatus == "P")
                                            ? "Your video is under review"
                                            : "Your video was rejected as there was some issue. Please follow the instructions and upload again."),
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    waitDuration: Duration(seconds: 1),
                                    showDuration: Duration(seconds: 4),
                                    padding: EdgeInsets.all(10),
                                    // height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      // 'Accepted',
                                      (videoApprovalStatus == "A")
                                          ? "Accepted"
                                          : ((videoApprovalStatus == "P")
                                              ? "Pending"
                                              : "Rejected"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: videoRejected,
                                child: SizedBox(
                                  height: 5,
                                ),
                              ),
                              Visibility(
                                visible: videoRejected,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      // 'Video Title',
                                      (pitchVideo['reject_reason'] == null)
                                          ? ""
                                          : pitchVideo['reject_reason'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.eye,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            // '80',
                                            pitchVideo['views_count']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     FaIcon(
                                      //       FontAwesomeIcons.solidBookmark,
                                      //       color: Colors.white,
                                      //       size: 20,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 16,
                                      //     ),
                                      //     Text(
                                      //       '20',
                                      //       style: TextStyle(
                                      //         color: Colors.white,
                                      //         fontSize: 18,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [],
                              )
                            ],
                          ),
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
