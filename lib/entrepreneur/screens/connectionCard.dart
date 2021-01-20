import 'dart:ui';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnectionCard extends StatefulWidget {
  final int index;

  ConnectionCard({this.index});

  @override
  _ConnectionCardState createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  var connection;
  Uri emailUri;
  Uri phoneUri;
  bool showBio = false;

  @override
  Widget build(BuildContext context) {
    connection = connections[widget.index];
    phoneUri = Uri(
      scheme: 'tel',
      path: connection['phone_no'].toString(),
    );
    emailUri = Uri(
      scheme: 'mailto',
      path: connection['email'].toString(),
    );
    // print(connection);
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Card(
            color: Color(0xFF162F42),
            // shape: RoundedRectangleBorder(
            //   side: BorderSide(color: Colors.white70, width: 1),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  // leading:
                  title: Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  // image:
                                  //     AssetImage('assets/images/profile.png'),
                                  image: connection['profile_pic'] == null
                                      ? AssetImage('assets/images/profile.png')
                                      : NetworkImage(connection['profile_pic']),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      40 /
                                      100,
                                  child: Text(
                                    (connection['name'] == null ||
                                            connection['name'] == "")
                                        ? "Name"
                                        : connection['name'],
                                    // "Mihir Milind Gandhi",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      40 /
                                      100,
                                  child: Text(
                                    // "Venture Capitalist",
                                    (connection['investor_type'] == null ||
                                            connection['investor_type'] == "")
                                        ? "Investor Type"
                                        : connection['investor_type'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        // Container(
                        //   child: Text(
                        //     connection['industry'],
                        //     style: TextStyle(fontSize: 18, color: Colors.white),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 9,
                                // child: InkWell(
                                child: Text(
                                  (connection['budget'] == null)
                                      ? "Funding Budget"
                                      : FUNDING_OPTIONS[connection['budget']],
                                  // 'Budget',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                //   onTap: () async {
                                //     if (await canLaunch(emailUri.toString())) {
                                //       await launch(emailUri.toString());
                                //     } else {
                                //       throw 'Could not launch ' +
                                //           emailUri.toString();
                                //     }
                                //   },
                                // ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 9,
                                // child: InkWell(
                                child: Text(
                                  (connection['email'] == null ||
                                          connection['email'] == "")
                                      ? "Email"
                                      : connection['email'],
                                  // "email",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                // onTap: () async {
                                //   if (await canLaunch(emailUri.toString())) {
                                //     await launch(emailUri.toString());
                                //   } else {
                                //     throw 'Could not launch ' +
                                //         emailUri.toString();
                                //   }
                                // },
                                // ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 9,
                                // child: InkWell(
                                child: Text(
                                  (connection['phone_no'] == null ||
                                          connection['phone_no'] == "")
                                      ? "Phone Number"
                                      : connection['phone_no'],
                                  // 'phone_no',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                // onTap: () async {
                                //   if (await canLaunch(phoneUri.toString())) {
                                //     await launch(phoneUri.toString());
                                //   } else {
                                //     throw 'Could not launch ' +
                                //         phoneUri.toString();
                                //   }
                                // },
                                // ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: [
                              // SizedBox(
                              //   width: 6,
                              // ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                  child: FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 9,
                                // child: InkWell(
                                child: Text(
                                  (connection['whatsapp_no'] == null ||
                                          connection['whatsapp_no'] == "")
                                      ? "Whatsapp Number"
                                      : connection['whatsapp_no'],
                                  // 'whatsapp_no',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                // onTap: () async {
                                //   if (await canLaunch(phoneUri.toString())) {
                                //     await launch(phoneUri.toString());
                                //   } else {
                                //     throw 'Could not launch ' +
                                //         phoneUri.toString();
                                //   }
                                // },
                                // ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Container(
                        //   child: Text(
                        //     connection['whatsapp_no'],
                        //     style: TextStyle(fontSize: 18, color: Colors.white),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 2,
                        // ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  child: Text(
                                    (connection['location']['city'] == null ||
                                            connection['location']['city'] ==
                                                "" ||
                                            connection['location']['country'] ==
                                                null ||
                                            connection['location']['country'] ==
                                                "")
                                        ? "City, Country"
                                        : connection['location']['city'] +
                                            ', ' +
                                            connection['location']['country'],

                                    // "Country, City",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: (connection['intro'] != ""),
                          child: SizedBox(
                            height: 8,
                          ),
                        ),
                        Visibility(
                          visible: (connection['intro'] != ""),
                          child: InkWell(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.description,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Container(
                                      child: Text(
                                        (showBio)
                                            ? "Click here to hide bio"
                                            : "Click here to view bio",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                showBio = !showBio;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: showBio,
                          child: SizedBox(
                            height: 12,
                          ),
                        ),
                        Visibility(
                          visible: showBio,
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      // connection['location']['city'] +
                                      //     ', ' +
                                      //     connection['location']['country'],
                                      "Bio: " + connection['intro'],
                                      // "Bio: kjdbfkjsdbf sdjbfkjsd bfk dskjbf kjdsb fkjb dskjf ksdj fkb dskjbf kdsjb fkjbsd kfjb sdkjb fkjd",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: FaIcon(
                        FontAwesomeIcons.envelope,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (await canLaunch(emailUri.toString())) {
                          await launch(emailUri.toString());
                        } else {
                          throw 'Could not launch ' + emailUri.toString();
                        }
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      child: FaIcon(
                        FontAwesomeIcons.phoneAlt,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (await canLaunch(phoneUri.toString())) {
                          await launch(phoneUri.toString());
                        } else {
                          throw 'Could not launch ' + phoneUri.toString();
                        }
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      child: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        FlutterOpenWhatsapp.sendSingleMessage(
                            connection['whatsapp_no'].toString().substring(1),
                            "Hello!");
                        // FlutterOpenWhatsapp.sendSingleMessage(
                        //     "+917738478888".toString().substring(1), "Hello!");
                      },
                      // onPressed: () async => await launch(
                      //     "https://wa.me/+917977754834?text=Hello"),
                    ),

                    // SizedBox(width: 8),
                  ],
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
}
