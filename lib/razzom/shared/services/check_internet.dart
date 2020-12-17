import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razzom/accounts/screens/wrapper.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

class checkInternet {
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "Internet Error",
                textAlign: TextAlign.left,
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
              content: new Text(
                "You are not connected to the internet! Please connect and try again.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Wrapper()),
                        (Route<dynamic> route) => false);
                    // Navigator.of(context).setState(() {});
                  },
                  child: new Text(
                    "Retry",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                new FlatButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: new Text(
                    "Exit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ]);
        });
  }

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          internetAvailable = true;
          // InternetStatus = "Connected to the Internet";
          // contentmessage = "Connected to the Internet";
          // _showDialog(context);
          break;
        case DataConnectionStatus.disconnected:
          internetAvailable = false;
          // _showDialog(context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
