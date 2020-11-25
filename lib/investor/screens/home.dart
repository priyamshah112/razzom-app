import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/investor/screens/videoCard.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
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
    if (!searchResults) {
      fundingCheckboxes = {
        0: true,
        1: true,
        2: true,
        3: true,
        4: true,
      };

      industryCheckboxes = {
        0: true,
        1: true,
        2: true,
        3: true,
        4: true,
      };
      searchText = "";
    }

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
          future: searchResults
              ? doNothing()
              : DatabaseService(uid: uid).getVideos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                width:
                    MediaQuery.of(context).copyWith().size.width * (100 / 100),
                child: Column(
                  children: [
                    // Expanded(
                    // flex: 12,
                    // child:
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width *
                          (100 / 100),
                      height: 60,
                      alignment: Alignment.center,
                      color: Color(0xFF162F42),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 12,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    // padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      height: 40,
                                      child: TextFormField(
                                        initialValue: searchText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          fillColor: Color(0xFFC5C6C7),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC5C6C7),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(20.0),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC5C6C7),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          searchResults = true;
                                          searchText = text.toLowerCase();
                                          print(searchText);
                                          print(videos.length.toString());
                                          setState(() {
                                            videosToDisplay =
                                                videos.where((video) {
                                              // print('videos length: ' +
                                              //     videos.length.toString());
                                              var videoFunding =
                                                  video.fundingRequired;
                                              var videoIndustry =
                                                  video.industry;
                                              print(videoFunding);
                                              return (fundingCheckboxes[
                                                          videoFunding] ==
                                                      true &&
                                                  industryCheckboxes[
                                                          ENTREPRENEUR_TYPES
                                                              .indexOf(
                                                                  videoIndustry)] ==
                                                      true);
                                            }).toList();
                                            print(videosToDisplay.length);
                                            // videosToDisplay.clear();
                                            videosToDisplay =
                                                videosToDisplay.where((video) {
                                              // print('videos length: ' +
                                              //     videos.length.toString());
                                              var videoTitle =
                                                  video.title.toLowerCase();
                                              // print(videoTitle);
                                              return videoTitle
                                                  .contains(searchText);
                                            }).toList();
                                            // print(videosToDisplay.length);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              child: Icon(
                                Icons.filter_alt,
                                color: Colors.white,
                                size: 40,
                              ),
                              onTap: showFilters,
                            ),
                          ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                InkWell(
                                  child: Image.asset(
                                    'assets/images/coins.png',
                                  ),
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
                        ],
                      ),
                    ),
                    // ),
                    Expanded(
                      // flex: 88,
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
                          child: (videosToDisplay.length == 0)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'No videos found!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: videosToDisplay.length,
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

  showFilters() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            title: Text(
              "Filters",
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
              height: 400,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Funding Required",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Container(
                          width: 200,
                          height: 150,
                          child: ListView(
                            // padding: EdgeInsets.all(0),

                            children: fundingCheckboxes.keys.map((int key) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: SizedBox(
                                  height: 30,
                                  child: new CheckboxListTile(
                                    title: new Text(
                                      FUNDING_OPTIONS[key],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    checkColor: Colors.white,
                                    contentPadding: EdgeInsets.all(0),
                                    value: fundingCheckboxes[key],
                                    onChanged: (bool val) {
                                      print(val);
                                      setState(() {
                                        fundingCheckboxes[key] = val;
                                      });
                                    },
                                    dense: true,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Industry",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),

                        Container(
                          width: 200,
                          height: 150,
                          child: ListView(
                            // padding: EdgeInsets.all(0),

                            children: fundingCheckboxes.keys.map((int key) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: SizedBox(
                                  height: 30,
                                  child: new CheckboxListTile(
                                    title: new Text(
                                      ENTREPRENEUR_TYPES[key],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    checkColor: Colors.white,
                                    contentPadding: EdgeInsets.all(0),
                                    value: industryCheckboxes[key],
                                    onChanged: (bool val) {
                                      print(val);
                                      setState(() {
                                        industryCheckboxes[key] = val;
                                      });
                                    },
                                    dense: true,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                  color: Color(0xFF0CE5DF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      color: Color(0xFF0CE5DF),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    print("Apply");
                    print(fundingCheckboxes);
                    print(industryCheckboxes);
                    // if (fundingCheckboxes.containsValue(true) ||
                    //     industryCheckboxes.containsValue(true)) {

                    //     }

                    searchResults = true;
                    // searchText = text.toLowerCase();
                    print(searchText);
                    print(videos.length.toString());
                    setState(() {
                      videosToDisplay = videos.where((video) {
                        // print('videos length: ' +
                        //     videos.length.toString());
                        var videoFunding = video.fundingRequired;
                        var videoIndustry = video.industry;
                        print(videoFunding);
                        return (fundingCheckboxes[videoFunding] == true &&
                            industryCheckboxes[ENTREPRENEUR_TYPES
                                    .indexOf(videoIndustry)] ==
                                true);
                      }).toList();
                      print(videosToDisplay.length);
                      // videosToDisplay.clear();
                      videosToDisplay = videosToDisplay.where((video) {
                        // print('videos length: ' +
                        //     videos.length.toString());
                        var videoTitle = video.title.toLowerCase();
                        // print(videoTitle);
                        return videoTitle.contains(searchText);
                      }).toList();
                      // print(videosToDisplay.length);
                    });
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }

                  //   setState(() {

                  //     // videosToDisplay.clear();
                  //     videosToDisplay = videos.where((video) {
                  //       // print('videos length: ' +
                  //       //     videos.length.toString());
                  //       var videoFunding = video.fundingRequired;
                  //       var videoIndustry = video.industry;
                  //       print(videoFunding);
                  //       return (fundingCheckboxes[videoFunding] == true &&
                  //           industryCheckboxes[
                  //                   ENTREPRENEUR_TYPES.indexOf(videoIndustry)] ==
                  //               true);
                  //     }).toList();
                  //     print(videosToDisplay.length);
                  //   });
                  //   Navigator.of(context).pop();
                  //   searchResults = true;
                  //   Navigator.pushReplacement(
                  //       context, MaterialPageRoute(builder: (context) => Home()));
                  //   // setState(() {
                  //   //   print("setting state");
                  //   // });
                  // },
                  ),
              SizedBox(
                width: 5,
              ),
              // FlatButton(
              //   child: Text(
              //     "Cancel",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          );
        });
      },
    );
    // setState(() {
    //   print("setting state");
    // });
  }

  doNothing() async {
    return "Done";
  }
}
