import 'package:razzom/razzom/models/customUser.dart';

bool showInfoScreens = true;
bool loading = false;
bool showSignIn = true;
String uid;
CustomUser currentUser = new CustomUser();
String signinError = "";
String registerError = "";
bool fromRegister = false;
bool fromForgotPassword = false;

List connections = new List();
List bookmarks = new List();
List videos = new List();

var pitchVideo;
