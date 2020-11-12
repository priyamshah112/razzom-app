import 'package:flutter/material.dart';
import 'package:razzom/investor/screens/drawer.dart';

class Connections extends StatefulWidget {
  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
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
                'Connections',
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
                          ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: Image.asset(
                              'assets/images/profile.png',
                            ),
                            title: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Industry',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    'Funding Required',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    'Phone number',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    'Whatsapp Number',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
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
