import 'package:flutter/material.dart';
import 'package:razzom/entrepreneur/screens/connectionCard.dart';
import 'package:razzom/entrepreneur/screens/drawer.dart';
import 'package:razzom/entrepreneur/screens/edashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/screens/no_internet.dart';
import 'package:razzom/razzom/shared/services/check_internet.dart';
import 'package:razzom/razzom/shared/services/database.dart';

class Connections extends StatefulWidget {
  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  void initState() {
    super.initState();
    checkInternet().checkConnection(context);
    // DatabaseService(uid: uid).getConnections();
  }

  @override
  void dispose() {
    checkInternet().listener.cancel();
    super.dispose();
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
                  'Connections',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 90,
              child: internetAvailable
                  ? FutureBuilder(
                      future: DatabaseService(uid: uid).getConnections(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print("Back from data");
                          return Container(
                            color: Color(0xFF0C1A24),
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    (100 / 100),
                            // height: MediaQuery.of(context).copyWith().size.height *
                            //         (100 / 100) -
                            //     169,
                            // child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: (connections.length == 0)
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'No connections yet!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 20),
                                          // ConnectionCard(
                                          //   index: 0,
                                          // ),
                                          // ConnectionCard(
                                          //   index: 1,
                                          // ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: connections.length,
                                      itemBuilder: (context, i) {
                                        return ConnectionCard(index: i);
                                      },
                                    ),
                            ),
                            // ),
                          );
                        } else {
                          return Container(
                            color: Color(0xFF0C1A24),
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    (100 / 100),
                            // height: MediaQuery.of(context).copyWith().size.height *
                            //         (100 / 100) -
                            // 169,
                            child: Loader(),
                          );
                        }
                      },
                    )
                  : NoInternet(notifyParent: refresh),
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
