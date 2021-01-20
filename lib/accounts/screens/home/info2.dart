import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/authentication/authentication.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

class Info2 extends StatelessWidget {
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
                                fontSize: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
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
                                fontSize: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
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
                flex: 38,
                child: Container(
                  color: Colors.white,
                  // height:
                  //     MediaQuery.of(context).copyWith().size.height * 35 / 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/info2_1.png',
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    25 /
                                    100,
                                // scale: 1.3,
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      (100 / 100),
                              child: Text(
                                'CHOOSE TO CONNECT WITH AN INVESTOR',
                                style: TextStyle(
                                  color: Color(0xFF0CE5DF),
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      5 /
                                      100,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bahnschrift',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      (90 / 100),
                              child: Text(
                                'Choose to connect with that Investor whose profile matches your needs',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      4 /
                                      100,
                                ),
                                textAlign: TextAlign.center,
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
                  //     MediaQuery.of(context).copyWith().size.height * 35 / 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/info2_2.png',
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    22 /
                                    100,
                                // scale: 1.3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                              child: Text(
                                'GET TALKING',
                                style: TextStyle(
                                  color: Color(0xFF0CE5DF),
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      5 /
                                      100,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bahnschrift',
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      (85 / 100),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: Text(
                                  'Use our WhatsApp integration to directly chat with your potential Investor',
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
                                ),
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
              showInfoScreens = false;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Authentication()),
                  (Route<dynamic> route) => false);
            }));
  }
}
