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
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).copyWith().size.height * 10 / 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          'razzom.com',
                          style: TextStyle(
                            color: Color(0xFF0CE5DF),
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Bahnschrift',
                          ),
                        ),
                        Text(
                          'Connect.Empower.Grow.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Bahnschrift',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).copyWith().size.height * 33 / 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          'CREATE AN AD CAMPAIGN',
                          style: TextStyle(
                            color: Color(0xFF0CE5DF),
                            fontSize: 20,
                            fontFamily: 'Bahnschrift',
                          ),
                        ),
                        Text(
                          'Create an Ad Campaign to present your Idea',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Image.asset(
                            'assets/images/info1_1.png',
                            scale: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height * 37 / 100,
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
                            fontSize: 20,
                            fontFamily: 'Bahnschrift',
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).copyWith().size.width *
                              (90 / 100),
                          child: Text(
                            'Post your Ad Campaign to all Investors browsing our platform',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Image.asset(
                            'assets/images/info1_2.png',
                            scale: 1,
                          ),
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
