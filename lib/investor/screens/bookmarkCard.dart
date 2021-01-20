import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razzom/investor/screens/bookmarks.dart';
import 'package:razzom/investor/screens/customVideoPlayer.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/services/database.dart';
import 'package:video_player/video_player.dart';

class BookmarkCard extends StatefulWidget {
  final int index;

  BookmarkCard({this.index});

  @override
  _BookmarkCardState createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  var bookmark;
  Razorpay _razorpay;
  var options;

  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future openCheckout(int amount) async {
    print("reached open checkout");
    options = {
      'key': 'rzp_test_Fh06M1SVtFZrFl',
      'amount': amount * 100,
      "currency": "USD",
      'name': 'Razzom',
      'description': 'Connect Coins',
      'prefill': {'contact': currentUser.phone, 'email': currentUser.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print("reached open checkout try");
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await DatabaseService(uid: uid).updateConnectCoins(response, options);
    Fluttertoast.showToast(msg: "Payment successful", timeInSecForIosWeb: 6);
    setState(() {
      print("setting state");
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 6);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 6);
  }

  @override
  Widget build(BuildContext context) {
    bookmark = bookmarks[widget.index];
    // print(bookmark);
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Card(
            color: Color(0xFF162F42),
            child: Column(
              children: <Widget>[
                (bookmark.videoUrl != "" && bookmark.videoUrl != null)
                    ? CustomVideoPlayer(
                        videoPlayerController: VideoPlayerController.network(
                          bookmark.videoUrl,
                        ),
                        looping: false,
                      )
                    : Container(
                        width: MediaQuery.of(context).copyWith().size.width,
                        height: 150,
                        child: Center(
                          child: Text(
                            'Cannot load video!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 50,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                bookmark.videoTitle == null
                                    ? "Video title"
                                    : bookmark.videoTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                bookmark.industry == null
                                    ? "Industry"
                                    : bookmark.industry,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                bookmark.fundingRequired == null
                                    ? "Funding Required"
                                    : FUNDING_OPTIONS[bookmark.fundingRequired],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Icon(
                                  Icons.bookmark_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onTap: () async {
                                  await unbookmark();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Bookmarks()),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !bookmark.isConnected,
                        child: Expanded(
                          flex: 35,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                RaisedButton(
                                  color: Color(0xFF0CE5DF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                      color: Color(0xFF0CE5DF),
                                    ),
                                  ),
                                  child: Text(
                                    'Connect',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .width *
                                            4 /
                                            100,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    if (currentUser.connects == 0) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            // titlePadding: EdgeInsets.fromLTRB(
                                            //     10, 20, 10, 0),
                                            title: Text(
                                              "Insufficient connect coins",
                                              // textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            backgroundColor: Color(0xFF162F42),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              side: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "You must purchase more connect coins in order to make this connection!",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              // FlatButton(
                                              // child:
                                              SizedBox(
                                                // width: 180,
                                                child: RaisedButton(
                                                  color: Color(0xFF0CE5DF),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    side: BorderSide(
                                                      color: Color(0xFF0CE5DF),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Buy Connects',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // await _auth.signOut();
                                                    print("BUY CONNECTS");
                                                    showBuyConnects();
                                                  },
                                                ),
                                              ),
                                              // ),
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
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            // titlePadding: EdgeInsets.fromLTRB(
                                            //     10, 20, 10, 0),
                                            title: Text(
                                              "Connect Confirmation",
                                              // textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            backgroundColor: Color(0xFF162F42),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              side: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "Are you sure you want to connect? Your connects balance will be " +
                                                  (currentUser.connects - 1)
                                                      .toString() +
                                                  " after the transaction.",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await connect();
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Bookmarks()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  "No",
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
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  unbookmark() async {
    var id = bookmark.id;
    print(id);
    await DatabaseService(uid: uid).deleteBookmark(id);
    // dynamic result = await DatabaseService(uid: uid).getUserData();
  }

  connect() async {
    print(bookmark.entrepreneurId);
    await DatabaseService(uid: uid).createConnection(bookmark.entrepreneurId);
    // dynamic result = await DatabaseService(uid: uid).getUserData();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).copyWith().size.width *
                            (55 / 100),
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
                          onPressed: () async {
                            print("1 connect");
                            await openCheckout(10);
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
                        width: MediaQuery.of(context).copyWith().size.width *
                            (55 / 100),
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
                          onPressed: () async {
                            print("5 connect");
                            await openCheckout(50);
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
                        width: MediaQuery.of(context).copyWith().size.width *
                            (55 / 100),
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
                          onPressed: () async {
                            Navigator.of(context).pop();
                            print("10 connect");
                            await openCheckout(95);
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
                        width: MediaQuery.of(context).copyWith().size.width *
                            (40 / 100),
                      ),
                    ],
                  )
                ],
              ),
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
}
