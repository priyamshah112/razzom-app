// import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/entrepreneur/screens/edashboard.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';
import 'package:razzom/razzom/shared/services/database.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = "";
  String imageErrorText = "";
  bool imageError = false;
  bool fileUploaded = false;
  bool fileUploading = false;

  // String name = currentUser.name;
  String phone = currentUser.phone;
  String whatsapp = currentUser.whatsapp;
  int funding = currentUser.funding;
  String profilePicUrl = currentUser.profilePicUrl;
  String description = currentUser.description;

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
                        // TextFormField(
                        //   style: TextStyle(color: Colors.white),
                        //   initialValue: currentUser.name,
                        //   decoration:
                        //       textInputDecoration.copyWith(hintText: 'Name'),
                        //   validator: (val) => val.isEmpty ? 'Enter name' : null,
                        //   onChanged: (val) {
                        //     setState(() {
                        //       name = val;
                        //     });
                        //   },
                        //   textInputAction: TextInputAction.next,
                        // ),
                        // SizedBox(
                        //   height: 16.0,
                        // ),
                        TextFormField(
                          initialValue: currentUser.phone,
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Phone Number',
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter a valid phone number' : null,
                          onChanged: (val) {
                            setState(() {
                              phone = val;
                            });
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          initialValue: currentUser.whatsapp,
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Whatsapp Number'),
                          validator: (val) => val.isEmpty
                              ? 'Enter a valid whatsapp number'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              whatsapp = val;
                            });
                          },
                          textInputAction: TextInputAction.next,
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
                            // width: 250,
                            child: DropdownButtonFormField(
                                value: currentUser.funding,
                                isDense: true,
                                hint: Text(
                                  'Funding Required',
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
                                    funding = val;
                                    print(funding);
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            width: MediaQuery.of(context).copyWith().size.width,
                            child: FlatButton(
                              padding: EdgeInsets.all(16),
                              onPressed: () async {
                                await uploadImage();
                              },
                              child: Text(
                                'Choose Profile Picture',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color(0xFF0C1A24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: Color(0xFF0C1A24),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: imageError,
                          child: SizedBox(
                            height: 10.0,
                          ),
                        ),
                        Visibility(
                          visible: imageError,
                          child: Text(
                            imageErrorText,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.0,
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
                          child: Text('File uploading...Please wait!'),
                        ),
                        Visibility(
                          visible: fileUploaded,
                          child: Text('File Uploaded!'),
                        ),
                        // SizedBox(
                        //   height: 20.0,
                        // ),
                        // TextFormField(
                        //   initialValue: currentUser.description,
                        //   keyboardType: TextInputType.multiline,
                        //   maxLines: null,
                        //   style: TextStyle(color: Colors.white),
                        //   decoration: textInputDecoration.copyWith(
                        //       hintText: 'Description'),
                        //   onChanged: (val) {
                        //     setState(() {
                        //       description = val;
                        //     });
                        //   },
                        //   textInputAction: TextInputAction.done,
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          color: Color(0xFF0CE5DF),
                          disabledColor: Colors.grey,
                          shape: fileUploading
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                )
                              : RoundedRectangleBorder(
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
                          onPressed: fileUploading
                              ? null
                              : () async {
                                  // print(user);
                                  if (_formKey.currentState.validate()) {
                                    print("Validated");

                                    await DatabaseService(uid: uid)
                                        .updateUserData(
                                            // name,
                                            phone,
                                            whatsapp,
                                            funding,
                                            profilePicUrl,
                                            description);
                                    dynamic result =
                                        await DatabaseService(uid: uid)
                                            .getUserData();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Edashboard()),
                                        (Route<dynamic> route) => false);
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
    // }
  }

  uploadImage() async {
    imageError = false;
    imageErrorText = "";
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    File image;

    // Check permission
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // Select Image
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

      // var fileSize = await file.length();
      // print("file size: " + fileSize.toString());
      var maxSize = 5 * 1024 * 1024;

      if (image != null) {
        var file = File(image.path);
        print("mime: " + mime(image.path));

        if (mime(image.path).toString().compareTo("image/jpeg") == 0 ||
            mime(image.path).toString().compareTo("image/jpg") == 0 ||
            mime(image.path).toString().compareTo("image/png") == 0) {
          var enc = await file.readAsBytes();
          print("LENGTH: " + enc.length.toString());
          if (enc.length < maxSize) {
            print("Size valid");
            // Upload to firebase
            setState(() {
              fileUploading = true;
            });

            var uploadTask = await _storage
                .ref()
                .child('profile_photos/' + uid)
                .putFile(file);

            if (uploadTask.bytesTransferred / uploadTask.totalBytes == 1) {
              setState(() {
                fileUploading = false;
                fileUploaded = true;
              });
              print("uploaded");
            }

            _storage
                .ref()
                .child('profile_photos/' + uid)
                .getDownloadURL()
                .then((url) => {profilePicUrl = url});
          } else {
            print('Invalid size');
            imageError = true;
            imageErrorText = "File must be less than 5MB";
          }
        } else {
          print('Invalid type');
          print(mime(image.path).toString().compareTo("image/jpeg"));
          imageError = true;
          imageErrorText = "File must be jpg or png";
        }
      } else {
        print("No path received");
      }
    } else {
      print("Grant permission and try again!");
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
