import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/home/info2.dart';

class Info1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Razzom',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: 'Bahnschrift',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C1A24),
      ),
      body: Container(
        color: Color(0xFF162F42),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                color: Colors.white,
                // height: MediaQuery.of(context).copyWith().size.height * 10 / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: MediaQuery.of(context).copyWith().size.height *
                          6 /
                          100,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            'razzom.com',
                            style: TextStyle(
                              color: Color(0xFF0CE5DF),
                              fontSize:
                                  MediaQuery.of(context).copyWith().size.width *
                                      8 /
                                      100,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Bahnschrift',
                            ),
                          ),
                          Text(
                            'Connect.Empower.Grow.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).copyWith().size.width *
                                      4 /
                                      100,
                              fontFamily: 'Bahnschrift',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 40,
              child: Container(
                color: Colors.white,
                // height:
                //     MediaQuery.of(context).copyWith().size.height * 33 / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            'CREATE AN AD CAMPAIGN',
                            style: TextStyle(
                              color: Color(0xFF0CE5DF),
                              fontSize:
                                  MediaQuery.of(context).copyWith().size.width *
                                      6 /
                                      100,
                              fontFamily: 'Bahnschrift',
                            ),
                          ),
                          Text(
                            'Create an Ad Campaign to present your Idea',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).copyWith().size.width *
                                      4 /
                                      100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Image.asset(
                              'assets/images/info1_1.png',
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  22 /
                                  100,

                              // scale: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 40,
              child: Container(
                // height:
                //     MediaQuery.of(context).copyWith().size.height * 37 / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            'LET INVESTORS FIND YOU',
                            style: TextStyle(
                              color: Color(0xFF0CE5DF),
                              fontSize:
                                  MediaQuery.of(context).copyWith().size.width *
                                      6 /
                                      100,
                              fontFamily: 'Bahnschrift',
                            ),
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    (90 / 100),
                            child: Text(
                              'Post your Ad Campaign to all Investors browsing our platform',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
                                    4 /
                                    100,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Image.asset(
                              'assets/images/info1_2.png',
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  22 /
                                  100,
                              // scale: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          Icons.navigate_next,
          color: Colors.black,
          size: 50,
        ),
        backgroundColor: Color(0xFF0CE5DF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Info2()),
          );
        },
      ),
    );
  }
}
