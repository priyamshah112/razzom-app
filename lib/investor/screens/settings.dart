import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/drawer.dart';
import 'package:razzom/investor/screens/home.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/services/check_internet.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void initState() {
    super.initState();
    checkInternet().checkConnection(context);
    // DatabaseService(uid: uid).getBookmarks();
  }

  @override
  void dispose() {
    super.dispose();
    checkInternet().listener.cancel();
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
                height: 50,
                alignment: Alignment.center,
                color: Color(0xFF162F42),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 90,
              child: Container(
                color: Color(0xFF0C1A24),
                height:
                    MediaQuery.of(context).copyWith().size.height * (100 / 100),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'razzominc@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Text(
                              'FAQs',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        85 /
                                        100,
                                    child: Text(
                                      'Can I re-upload my video if I have made changes?',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 18,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        85 /
                                        100,
                                    child: Text(
                                      'Yes, absolutely. To re-upload you video pitch, simply go into your settings, edit profile and click on the edit option. Here, upload your new video which may take up to 24 hours to be seen on the feed as we analyse it and make sure it follows all our guidelines.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        85 /
                                        100,
                                    child: Text(
                                      'How do I purchase connects?',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 18,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        85 /
                                        100,
                                    child: Text(
                                      'To purchase connect coins, click on the coins on the top right hand corner of the screen. This will release a pop up screen with all the options for purchasing connect bundles.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        85 /
                                        100,
                                    child: Text(
                                      'Can I make multiple accounts?',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 18,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        85 /
                                        100,
                                    child: Text(
                                      'Yes, you can make multiple accounts however, these accounts must be on different email addresses (for each venture).',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}
