import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razzom/razzom/models/customUser.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference entrepreneurCollection =
      FirebaseFirestore.instance.collection('entrepreneur');
  final CollectionReference investorCollection =
      FirebaseFirestore.instance.collection('investor');
  final CollectionReference connectionsCollection =
      FirebaseFirestore.instance.collection('connections');
  final CollectionReference bookmarksCollection =
      FirebaseFirestore.instance.collection('investor_video_bookmark');
  final CollectionReference videosCollection =
      FirebaseFirestore.instance.collection('videos');

  Future createUserData(CustomUser user) async {
    print("reached db start");
    var createdOn = new DateTime.now();
    userCollection.doc(uid).set({
      'uid': uid,
      'email': user.email,
      'last_login': null,
      'type': user.userType,
      'created_on': createdOn,
      'is_deleted': false,
      'updated_on': null,
      'deleted_on': null,
    });
    if (user.userType == "Entrepreneur") {
      print("reached entrepreneur db");
      return await entrepreneurCollection.doc(uid).set({
        'uid': uid,
        'name': user.name,
        'phone_no': user.phone,
        'whatsapp_no': user.whatsapp,
        'email': user.email,
        'location': {
          "city": user.location['city'],
          "country": user.location['country'],
        },
        'industry': user.entrepreneurOffering,
        'funding_required': user.funding,
        'profile_pic': null,
        'video_id': null,
        'created_on': createdOn,
        'is_deleted': false,
        'updated_on': null,
        'deleted_on': null,
      });
    } else if (user.userType == "Investor") {
      print("reached investor db");
      return await investorCollection.doc(uid).set({
        'name': user.name,
        'phone_no': user.phone,
        'whatsapp_no': user.whatsapp,
        'email': user.email,
        'location': {
          "city": user.location['city'],
          "country": user.location['country'],
        },
        'investor_type': user.investorType,
        'budget': user.funding,
        'profile_pic': null,
        'connects_avail': 0,
        'intro': "",
        'created_on': createdOn,
        'is_deleted': false,
        'updated_on': null,
        'deleted_on': null,
      });
    }
  }

  Future updateUserData(String name, String phone, String whatsapp, int funding,
      String profilePicUrl, String description) async {
    print("reached db update");
    print(currentUser.userType);

    var updatedOn = new DateTime.now();
    if (currentUser.userType == "Entrepreneur") {
      print("reached entrepreneur db");
      return await entrepreneurCollection.doc(uid).update({
        'name': name,
        'phone_no': phone,
        'whatsapp_no': whatsapp,
        'funding_required': funding,
        'profile_pic': profilePicUrl,
        'updated_on': updatedOn,
      });
    } else if (currentUser.userType == "Investor") {
      print("reached investor db");
      return await investorCollection.doc(uid).update({
        'name': name,
        'phone_no': phone,
        'whatsapp_no': whatsapp,
        'funding_required': funding,
        'profile_pic': profilePicUrl,
        'intro': description,
        'updated_on': updatedOn,
      });
    }
  }

  Future getData() async {
    print("Getting user data");
    await getUserData();
    await getConnections();
    await getBookmarks();
    await getVideos();
    // return true;
  }

  Future getUserData() async {
    print('get user data called');
    var userType = await userCollection.doc(uid).get();
    currentUser.userType = userType.data()['type'];
    var userData = await investorCollection.doc(uid).get();
    var currentUserData = userData.data();
    currentUser.name = currentUserData['name'];
    currentUser.phone = currentUserData['phone_no'];
    currentUser.whatsapp = currentUserData['whatsapp_no'];
    currentUser.email = currentUserData['email'];
    currentUser.funding = currentUserData['budget'];
    currentUser.description = currentUserData['intro'];
    currentUser.connects = currentUserData['connects_avail'];
    currentUser.investorType = currentUserData['investor_type'];
    currentUser.profilePicUrl = currentUserData['profile_pic'];
    currentUser.location['city'] = currentUserData['location']['city'];
    currentUser.location['country'] = currentUserData['location']['country'];

    print(currentUser.profilePicUrl);
    // loading = false;
    return 'Done';
  }

  getConnections() async {
    connections.clear();
    var connectionsData =
        await connectionsCollection.where('investor_id', isEqualTo: uid).get();
    for (var i = 0; i < connectionsData.size; i++) {
      var entrepreneurId = connectionsData.docs[i].data()['entrepreneur_id'];
      var connection = await entrepreneurCollection.doc(entrepreneurId).get();
      if (!connection['is_deleted']) {
        connections.add(connection);
        print('connection added');
      }
    }
    print(connections);
    return 'Done';
  }

  getBookmarks() async {
    bookmarks.clear();
    var bookmarksData =
        await bookmarksCollection.where('investor_id', isEqualTo: uid).get();
    for (var i = 0; i < bookmarksData.size; i++) {
      var bookmark = bookmarksData.docs[i];
      if (!bookmark['is_deleted']) {
        bookmarks.add(bookmark);
        print('bookmark added: ' + bookmark.data().toString());
      }
      // print(bookmark.data());
      // print(connection);
    }
    print(bookmarks);
    return 'Done';
  }

  getVideos() async {
    print("reached get videos");
    videos.clear();
    var videosData =
        await videosCollection.where('approval_status', isEqualTo: "P").get();
    print(videosData.size);
    for (var i = 0; i < videosData.size; i++) {
      // FILTER BOOKMARKED LATER
      var video = videosData.docs[i];
      // if (!video['is_deleted']) {
      videos.add(video);
      // print('video added: ' + video.data().toString());
      // }
      // print(video.data());
      // print(connection);
    }
    return 'Done';
  }

  Future deleteBookmark(String id) async {
    print("reached db delete bookmark");
    var updatedOn = new DateTime.now();

    return await bookmarksCollection.doc(id).update({
      'is_deleted': true,
      'updated_on': updatedOn,
      'deleted_on': updatedOn,
    });
  }
}
