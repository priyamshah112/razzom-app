import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();

  final Function() notifyParent;
  NoInternet({Key key, @required this.notifyParent}) : super(key: key);
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 50.0,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'No internet available',
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                widget.notifyParent();
              },
              child: new Text(
                "Retry",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
