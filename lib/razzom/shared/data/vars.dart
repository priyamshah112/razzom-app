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
bool fromEdashboard = false;
bool searchResults = false;

List connections = new List();
List bookmarks = new List();
List videos = new List();
List videosToDisplay = new List();

var pitchVideo;

Map<int, bool> fundingCheckboxes = {
  0: true,
  1: true,
  2: true,
  3: true,
  4: true,
};

Map<int, bool> industryCheckboxes = {
  0: true,
  1: true,
  2: true,
  3: true,
  4: true,
};

String searchText = "";
