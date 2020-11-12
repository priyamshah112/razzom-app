// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:razzom/razzom/models/customUser.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';
// import 'dart:io';
import 'package:flutter/widgets.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  CustomUser user = new CustomUser();

  String error = "";

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loader();
    } else {
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
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
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
                            ),
                          ),
                          Text(
                            'Connect.Empower.Grow.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Name'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter name' : null,
                            onChanged: (val) {
                              setState(() {
                                user.name = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Phone Number'),
                            validator: (val) => val.isEmpty
                                ? 'Enter a valid phone number'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                user.phone = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Whatsapp Number'),
                            validator: (val) => val.isEmpty
                                ? 'Enter a valid whatsapp number'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                user.whatsapp = val;
                              });
                            },
                          ),
                          Visibility(
                            visible: true,
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                              width: 250,
                              child: DropdownButtonFormField(
                                  isDense: true,
                                  hint: Text(
                                    'Funding Budget',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  dropdownColor: Color(0xFF0C1A24),
                                  decoration: textInputDecoration,
                                  items: FUNDING_OPTIONS.map((funding) {
                                    return DropdownMenuItem(
                                      value: FUNDING_OPTIONS.indexOf(funding),
                                      child: Text(
                                        '$funding',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      user.funding = val;
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Description'),
                            onChanged: (val) {
                              setState(() {
                                user.description = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            color: Color(0xFF0CE5DF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                color: Color(0xFF0CE5DF),
                              ),
                            ),
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              print(user);
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                // dynamic result = await _auth
                                //     .registerWithEmailAndPassword(user);
                                // print("RESULT: " + result.toString());
                                // if (result == null) {
                                //   setState(() {
                                //     error = "ERROR";
                                //     loading = false;
                                //   });
                                // }
                                setState(() {
                                  loading = false;
                                });
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
              ],
            ),
          ),
        ),
      );
    }
  }
}

// class ImageCapture extends StatefulWidget {
//   @override
//   _ImageCaptureState createState() => _ImageCaptureState();
// }

// class _ImageCaptureState extends State<ImageCapture> {
//   File _imageFile;
//   Future<void> _pickImage(ImageSource source) async {
//     File selected = await ImagePicker.pickImage(source: source);
//     setState(() {
//       _imageFile = selected;
//     });
//   }

//   Future<void> _cropImage() async {
//     File cropped = await ImageCropper.cropImage(sourcePath: _imageFile.path);
//     setState(() {
//       _imageFile = cropped ?? _imageFile;
//     });
//   }

//   void clear()

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
