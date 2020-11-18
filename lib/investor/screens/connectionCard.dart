import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectionCard extends StatelessWidget {
  final int index;
  var connection;
  Uri emailUri;
  Uri phoneUri;

  ConnectionCard({this.index});

  @override
  Widget build(BuildContext context) {
    connection = connections[index];
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  leading: Container(
                    width: 80,
                    height: 80,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.contain,
                        image: connection['profile_pic'] == null
                            ? AssetImage('assets/images/profile.png')
                            : NetworkImage(connection['profile_pic']),
                      ),
                    ),
                  ),
                  title: Container(
                    child: Text(
                      connection['name'],
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Text(
                            connection['industry'],
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
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
                                child: InkWell(
                                  child: Text(
                                    FUNDING_OPTIONS[
                                        connection['funding_required']],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onTap: () async {
                                    if (await canLaunch(emailUri.toString())) {
                                      await launch(emailUri.toString());
                                    } else {
                                      throw 'Could not launch ' +
                                          emailUri.toString();
                                    }
                                  },
                                ),
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
                                child: InkWell(
                                  child: Text(
                                    connection['email'],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onTap: () async {
                                    if (await canLaunch(emailUri.toString())) {
                                      await launch(emailUri.toString());
                                    } else {
                                      throw 'Could not launch ' +
                                          emailUri.toString();
                                    }
                                  },
                                ),
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
                                child: InkWell(
                                  child: Text(
                                    connection['phone_no'],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onTap: () async {
                                    if (await canLaunch(phoneUri.toString())) {
                                      await launch(phoneUri.toString());
                                    } else {
                                      throw 'Could not launch ' +
                                          phoneUri.toString();
                                    }
                                  },
                                ),
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
                                    connection['location']['city'] +
                                        ', ' +
                                        connection['location']['country'],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Image.asset(
                        'assets/images/whatsapp.png',
                        scale: 1.5,
                      ),
                      onPressed: () {
                        FlutterOpenWhatsapp.sendSingleMessage(
                            "+917738478888".toString().substring(1), "Hello!");
                      },
                      // onPressed: () async => await launch(
                      //     "https://wa.me/+917977754834?text=Hello"),
                    ),
                    SizedBox(width: 8),
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

// return Padding(
//       padding: EdgeInsets.all(0),
//       child: Column(
//         children: [
//           Card(
//             color: Color(0xFF162F42),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 ListTile(
//                   contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
//                   leading: Container(
//                     width: 80,
//                     height: 80,
//                     decoration: new BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: new DecorationImage(
//                         fit: BoxFit.contain,
//                         image: connection['profile_pic'] == null
//                             ? AssetImage('assets/images/profile.png')
//                             : NetworkImage(connection['profile_pic']),
//                       ),
//                     ),
//                   ),
//                   title: Container(
//                     width:
//                         MediaQuery.of(context).copyWith().size.width * 50 / 100,
//                     child: Text(
//                       connection['name'],
//                       style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                       softWrap: true,
//                     ),
//                   ),
//                   subtitle: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           child: Row(
//                             children: [
//                               Text(
//                                 connection['industry'],
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Text(
//                                 FUNDING_OPTIONS[connection['funding_required']],
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context)
//                                         .copyWith()
//                                         .size
//                                         .width *
//                                     50 /
//                                     100,
//                                 child: Text(
//                                   connection['email'],
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.white),
//                                   softWrap: true,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Text(
//                                 connection['phone_no'],
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Text(
//                                 connection['whatsapp_no'],
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context)
//                                         .copyWith()
//                                         .size
//                                         .width *
//                                     50 /
//                                     100,
//                                 child: Text(
//                                   connection['location']['city'] +
//                                       ', ' +
//                                       connection['location']['country'],
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.white),
//                                   softWrap: true,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     TextButton(
//                       child: Image.asset(
//                         'assets/images/whatsapp.png',
//                         scale: 1.5,
//                       ),
//                       onPressed: () {/* ... */},
//                     ),
//                     SizedBox(width: 8),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//         ],
//       ),
//     );
