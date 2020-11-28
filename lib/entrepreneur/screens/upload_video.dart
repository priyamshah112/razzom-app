// import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:razzom/entrepreneur/screens/edashboard.dart';
import 'package:razzom/entrepreneur/screens/videoPitch.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/razzom/shared/services/database.dart';

class UploadVideo extends StatefulWidget {
  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  final _formKey = GlobalKey<FormState>();

  String error = "";
  String videoErrorText = "";
  bool videoError = false;
  bool fileUploaded = false;
  bool fileUploading = false;

  String title = "";
  String videoUrl = "";

  @override
  void initState() {
    // if (!fileUploaded && !fileUploading) {
    // print("videoID: " + currentUser.videoId);
    if (currentUser.videoId == null) {
      title = "";
      videoUrl = "";
    } else {
      // title = "Title";
      title = pitchVideo['title'];
      videoUrl = pitchVideo['url'];
    }
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (loading) {
    //   return Loader();
    // } else {
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
      body: FutureBuilder(
          future: DatabaseService(uid: uid).getPitchVideo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Color(0xFF162F42),
                height: MediaQuery.of(context).copyWith().size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Expanded(
                      // flex: 10,
                      // child:
                      Container(
                        color: Colors.white,
                        // height: MediaQuery.of(context).copyWith().size.height * 10 / 100,
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
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Bahnschrift',
                                    ),
                                  ),
                                  Text(
                                    'Connect.Empower.Grow.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Bahnschrift',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ),
                      // Expanded(
                      // flex: 40,
                      // child:
                      Container(
                        color: Colors.white,
                        // height:
                        //     MediaQuery.of(context).copyWith().size.height * 33 / 100,
                        child:
                            // Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // children: [
                            Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Video Upload',
                                    // pitchVideo['title'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Instructions: ',
                                    // pitchVideo['title'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (90 / 100),
                                    child: Text(
                                      '- The maximum size for a video file is 5 Mb',
                                      // pitchVideo['title'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (90 / 100),
                                    child: Text(
                                      '- The Pitch Video must not include any of the following:',
                                      // pitchVideo['title'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (90 / 100),
                                    child: Text(
                                      '1. Name and Logo of the company/venture in any form',
                                      // pitchVideo['title'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (90 / 100),
                                    child: Text(
                                      '2. Name & Contact of any employee or owner of the venture',
                                      // pitchVideo['title'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        (90 / 100),
                                    child: Text(
                                      '3. Name of the product or service provided',
                                      // pitchVideo['title'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // ],
                        // ),
                      ),
                      // ),
                      // Expanded(
                      // flex: 40,
                      // child:
                      Container(
                        color: Color(0xFF162F42),
                        width: MediaQuery.of(context).copyWith().size.height,
                        // child: Text('FORM'),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      0.7,
                                  child: TextFormField(
                                    initialValue: title,
                                    style: TextStyle(color: Colors.black),
                                    decoration: textInputDecoration2.copyWith(
                                      hintText: 'Title',
                                    ),
                                    textAlign: TextAlign.center,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter a title' : null,
                                    onChanged: (val) {
                                      title = val;
                                      print("title: " + title);

                                      // setState(() {
                                      //   // FocusScope.of(context)
                                      //   //     .requestFocus(new FocusNode());
                                      // });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Visibility(
                                  visible: true,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        0.7,
                                    child: FlatButton(
                                      padding: EdgeInsets.all(16),
                                      onPressed: () async {
                                        await uploadVideo();
                                      },
                                      child: Text(
                                        'Choose Pitch Video',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: videoError,
                                  child: SizedBox(
                                    height: 10.0,
                                  ),
                                ),
                                Visibility(
                                  visible: videoError,
                                  child: Text(
                                    videoErrorText,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: fileUploaded | fileUploading,
                                  child: SizedBox(
                                    height: 8.0,
                                  ),
                                ),
                                Visibility(
                                  visible: fileUploading,
                                  child: Text(
                                    'File uploading...Please wait!',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: fileUploaded,
                                  child: Text(
                                    'File Uploaded!',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                RaisedButton(
                                  color: Color(0xFF0CE5DF),
                                  disabledColor: Colors.grey,
                                  shape: fileUploading
                                      ? RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        )
                                      : RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: BorderSide(
                                            color: Color(0xFF0CE5DF),
                                          ),
                                        ),
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: fileUploading
                                      ? null
                                      : () async {
                                          // print(user);
                                          if (_formKey.currentState
                                              .validate()) {
                                            print("Validated" + title);
                                            if (title == "" || videoUrl == "") {
                                              error = "Please fill all fields";
                                            } else {
                                              await DatabaseService(uid: uid)
                                                  .updatePitchVideo(title,
                                                      videoUrl, fileUploaded);
                                              // dynamic result =
                                              //     await DatabaseService(uid: uid)
                                              //         .getUserData();
                                              if (fromEdashboard) {
                                                fromEdashboard = false;
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Edashboard()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              } else {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                VideoPitch()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              }
                                            }
                                          }
                                        },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Loader(),
              );
            }
          }),
    );
    // }
  }

  uploadVideo() async {
    setState(() {
      videoError = false;
      videoErrorText = "";
    });
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    File video;

    // Check permission
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // Select Image
      video = await ImagePicker.pickVideo(source: ImageSource.gallery);

      // var fileSize = await file.length();
      // print("file size: " + fileSize.toString());
      var maxSize = 50 * 1024 * 1024;

      if (video != null) {
        var file = File(video.path);
        print("mime: " + mime(video.path));
        // print("mime: " + (lookupMimeType(video.path)));
        // print("extension: " + p.extension);
        print(path.basename(video.path));
        String mimeType = mime(video.path).toString();
        // print(mime(video.path).toString().compareTo("image/jpeg"));

        // .mp4,.mov,.wmv,.flv,.avi,.webm,.mkv
        // if (true) {
        if (mimeType.compareTo("video/mp4") == 0) {
          //  ||
          //     mimeType.compareTo("video/x-matroska") == 0 ||
          //     mimeType.compareTo("video/x-flv") == 0 ||
          //     mimeType.compareTo("video/x-msvideo") == 0 ||
          //     mimeType.compareTo("video/quicktime") == 0 ||
          //     mimeType.compareTo("video/webm") == 0 ||
          //     mimeType.compareTo("video/x-ms-wmv") == 0) {
          // if (true) {
          var enc = await file.readAsBytes();
          print("LENGTH: " + enc.length.toString());
          if (enc.length < maxSize) {
            print("Size valid");
            // Upload to firebase
            setState(() {
              fileUploading = true;
              fileUploaded = false;
            });

            var uploadTask =
                await _storage.ref().child('pitch_videos/' + uid).putFile(file);

            if (uploadTask.bytesTransferred / uploadTask.totalBytes == 1) {
              setState(() {
                fileUploading = false;
                fileUploaded = true;
              });
              print("uploaded");
            }

            _storage
                .ref()
                .child('pitch_videos/' + uid)
                .getDownloadURL()
                .then((url) => {videoUrl = url});
          } else {
            print('Invalid size');
            setState(() {
              videoError = true;
              videoErrorText = "File must be less than 50 MB";
            });
          }
        } else {
          print('Invalid type');
          // print(mime(video.path).toString().compareTo("image/jpeg"));
          setState(() {
            videoError = true;
            videoErrorText = "Invalid file type. Please upload mp4 file.";
          });
        }
      } else {
        print("No path received");
      }
    } else {
      print("Grant permission and try again!");
    }
  }
}
