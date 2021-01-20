import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/razzom/models/customBookmark.dart';
import 'package:razzom/razzom/models/customUser.dart';
import 'package:razzom/razzom/models/customVideo.dart';
import 'package:razzom/razzom/shared/data/vars.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final AuthService _auth = AuthService();

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
  final CollectionReference paymentCollection =
      FirebaseFirestore.instance.collection('payment');
  final CollectionReference videoViewsCollection =
      FirebaseFirestore.instance.collection('video_views');

  Future createUserData(CustomUser user) async {
    print("reached db start");
    var date = new DateTime.now();
    userCollection.doc(uid).set({
      'uid': uid,
      'email': user.email,
      'last_login': null,
      'type': user.userType,
      'created_on': date,
      'is_deleted': false,
      'updated_on': date,
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
        'created_on': date,
        'is_deleted': false,
        'updated_on': date,
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
        'created_on': date,
        'is_deleted': false,
        'updated_on': date,
        'deleted_on': null,
      });
    }
  }

  Future updateLastLogin() async {
    var date = new DateTime.now();
    await userCollection.doc(uid).update({
      'last_login': date,
    });
  }

  Future updateUserData(String phone, String whatsapp, int funding,
      String profilePicUrl, String description) async {
    print("reached db update");
    print(currentUser.userType);

    var updatedOn = new DateTime.now();
    if (currentUser.userType == "Entrepreneur") {
      print("reached entrepreneur db");
      return await entrepreneurCollection.doc(uid).update({
        // 'name': name,
        'phone_no': phone,
        'whatsapp_no': whatsapp,
        'funding_required': funding,
        'profile_pic': profilePicUrl,
        'updated_on': updatedOn,
      });
    } else if (currentUser.userType == "Investor") {
      print("reached investor db");
      return await investorCollection.doc(uid).update({
        // 'name': name,
        'phone_no': phone,
        'whatsapp_no': whatsapp,
        'budget': funding,
        'profile_pic': profilePicUrl,
        'intro': description,
        'updated_on': updatedOn,
      });
    }
  }

  // Future getData() async {
  //   print("Getting user data");
  //   await getUserData();
  //   await getConnections();
  //   await getBookmarks();
  //   await getVideos();
  //   // return true;
  // }

  Future getInitialData() async {
    print("Getting Initial data");
    var userType = await userCollection.doc(uid).get();
    print(userType);
    currentUser.userType = userType.data()['type'];
    print("user type: " + currentUser.userType);
    return "Done";
  }

  Future getUserData() async {
    print('get user data called');
    bool userExistsInDb = await checkUserInDb(currentUser.email);

    // if (userExistsInDb) {
    if (currentUser.userType == "Entrepreneur") {
      print("Entrepreneur DB");
      var userData = await entrepreneurCollection.doc(uid).get();
      var currentUserData = userData.data();
      currentUser.name = currentUserData['name'];
      currentUser.phone = currentUserData['phone_no'];
      currentUser.whatsapp = currentUserData['whatsapp_no'];
      currentUser.email = currentUserData['email'];
      currentUser.funding = currentUserData['funding_required'];
      currentUser.entrepreneurOffering = currentUserData['industry'];
      currentUser.videoId = currentUserData['video_id'];
      currentUser.profilePicUrl = currentUserData['profile_pic'];
      currentUser.location['city'] = currentUserData['location']['city'];
      currentUser.location['country'] = currentUserData['location']['country'];
      print(currentUser.profilePicUrl);
      return 'Done';
    } else if (currentUser.userType == "Investor") {
      print("Investor");
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
      return 'Done';
    }
    // } else {
    //   await _auth.signOut().then((res) {
    //     showSignIn = true;
    //     // signedOut = true;
    //     // Navigator.of(context).pushAndRemoveUntil(
    //     //     MaterialPageRoute(builder: (context) => Authentication()),
    //     //     (Route<dynamic> route) => false);
    //   });
    //   return "User Blocked";
    // }
  }

  Future getConnections() async {
    connections.clear();
    if (currentUser.userType == "Entrepreneur") {
      var connectionsData = await connectionsCollection
          .where('entrepreneur_id', isEqualTo: uid)
          .get();
      print("data received");
      for (var i = 0; i < connectionsData.size; i++) {
        var investorId = connectionsData.docs[i].data()['investor_id'];
        var connection = await investorCollection.doc(investorId).get();
        print(connection.data().toString());
        if (!connection.data()['is_deleted']) {
          connections.add(connection);
          print('connection added: ');
        }
      }
      print(connections);
      return 'Done';
    } else if (currentUser.userType == "Investor") {
      var connectionsData = await connectionsCollection
          .where('investor_id', isEqualTo: uid)
          .get();
      // print("data received: " + connectionsData.docs.toString());
      print(connectionsData.size);
      for (var i = 0; i < connectionsData.size; i++) {
        // print("data received: " + connectionsData.docs[i].data().toString());
        var entrepreneurId = connectionsData.docs[i].data()['entrepreneur_id'];
        var connection = await entrepreneurCollection.doc(entrepreneurId).get();
        if (!connection.data()['is_deleted']) {
          connections.add(connection);
          print('connection added: ' + connection.data()['name'].toString());
        }
      }
      print(connections);
      return 'Done';
    }
  }

  Future getPitchVideo() async {
    if (currentUser.videoId != null) {
      pitchVideo = await videosCollection.doc(currentUser.videoId).get();
      print(pitchVideo.data().toString());
      print(pitchVideo.data()['url']);
    }
    return 'Done';
  }

  Future updatePitchVideo(
      String title, String videoUrl, bool fileUploaded) async {
    print("reached videos db update");
    print(title);
    var date = new DateTime.now();

    // print(currentUser.userType);
    if (fileUploaded) {
      if (currentUser.videoId != null) {
        var oldVideo = await videosCollection.doc(currentUser.videoId).update({
          'is_deleted': true,
          'updated_on': date,
          'deleted_on': date,
        });
      }

      var newVideo = await videosCollection.doc().set({
        'title': title,
        'url': videoUrl,
        'views_count': 0,
        'reject_reason': "",
        'funding_required': currentUser.funding,
        'industry': currentUser.entrepreneurOffering,
        'entrepreneur_id': uid,
        'approval_status': "P",
        'created_on': date,
        'is_deleted': false,
        'updated_on': date,
        'deleted_on': null,
      });

      var newVideoData =
          await videosCollection.where('url', isEqualTo: videoUrl).get();

      print(newVideoData.docs[0].data().toString());

      var updateEntrepreneur = await entrepreneurCollection.doc(uid).update({
        'video_id': newVideoData.docs[0].id,
        'updated_on': date,
      });

      currentUser.videoId = newVideoData.docs[0].id;

      // await getUserData();
    } else {
      print("else");
      print(title);
      var oldVideo = await videosCollection.doc(currentUser.videoId).update({
        'title': title,
        // 'views_count': 0,
        'reject_reason': "",
        // 'funding_required': currentUser.funding,
        // 'industry': currentUser.entrepreneurOffering,
        'entrepreneur_id': uid,
        'approval_status': "P",
        'updated_on': date,
      });
    }
  }

  Future getBookmarks() async {
    bookmarks.clear();
    var bookmarksData = await bookmarksCollection
        .where('investor_id', isEqualTo: uid)
        .where('is_deleted', isEqualTo: false)
        .get();
    // print(bookmarksData.toString());
    for (var i = 0; i < bookmarksData.size; i++) {
      var bookmark = bookmarksData.docs[i];
      bool isConnected = false;
      // String connectionId = "";
      var connection = await connectionsCollection
          .where('investor_id', isEqualTo: uid)
          .where('entrepreneur_id', isEqualTo: bookmark['entrepreneur_id'])
          .where('is_deleted', isEqualTo: false)
          .get();
      var entrepreneur =
          await entrepreneurCollection.doc(bookmark['entrepreneur_id']).get();
      // print(entrepreneur.toString());
      // print(bookmark['entrepreneur_id']);
      if (connection.docs.length != 0) {
        // print('connection: ' + connection.docs[0].data().toString());
        isConnected = true;
        // connectionId = connection.docs[0].id;
      }
      print(entrepreneur.toString());

      CustomBookmark bm = new CustomBookmark(
          bookmark.id,
          bookmark['video_id'],
          bookmark['video_title'],
          bookmark['video_url'],
          isConnected,
          bookmark['entrepreneur_id'],
          entrepreneur['funding_required'],
          entrepreneur['industry']);
      bookmarks.add(bm);

      // if (!bookmark['is_deleted']) {
      //   bookmarks.add(bookmark);
      //   print('bookmark added: ' + bookmark.data().toString());
      // }
      // print(bookmark.data()['id']);
      // print(connection);
    }
    // print(bookmarks);
    return 'Done';
  }

  Future getVideos() async {
    print("reached get videos");
    videos.clear();
    videosToDisplay.clear();
    searchResults = false;
    var videosData = await videosCollection
        .where('approval_status', isEqualTo: "A")
        .where('is_deleted', isEqualTo: false)
        .orderBy('updated_on', descending: true)
        .get();
    print(videosData.size);
    for (var i = 0; i < videosData.size; i++) {
      // FILTER BOOKMARKED LATER
      var video = videosData.docs[i];
      // if (!video['is_deleted']) {
      // print(video.data().toString());
      bool isConnected = false;
      // String connectionId = "";
      var connection = await connectionsCollection
          .where('investor_id', isEqualTo: uid)
          .where('entrepreneur_id', isEqualTo: video['entrepreneur_id'])
          .where('is_deleted', isEqualTo: false)
          .get();
      if (connection.docs.length == 1) {
        // print('connection: ' + connection.docs[0].data().toString());
        isConnected = true;
        // connectionId = connection.docs[0].id;
      }
      var bookmark = await bookmarksCollection
          .where('investor_id', isEqualTo: uid)
          .where('video_id', isEqualTo: video.id)
          .where('is_deleted', isEqualTo: false)
          .get();
      bool isBookmarked = false;
      String bookmarkId = "";
      if (bookmark.docs.length == 1) {
        // print('bookmark: ' + bookmark.docs[0].data().toString());
        isBookmarked = true;
        bookmarkId = bookmark.docs[0].id;
      }

      CustomVideo vid = new CustomVideo(
        video.id,
        video['title'],
        video['url'],
        isBookmarked,
        bookmarkId,
        isConnected,
        video['entrepreneur_id'],
        video['funding_required'],
        video['industry'],
      );
      videos.add(vid);
      if (isBookmarked) {
        print("BOOKMARKEDDD");
      }

      // print('video added: ' + vid.title + " --> " + vid.url);

      // }
      // print(video.data());
      // print(connection);
    }
    var userData = await investorCollection.doc(uid).get();
    var currentUserData = userData.data();
    currentUser.connects = currentUserData['connects_avail'];
    print("connects: " + currentUser.connects.toString());
    print(videos.length.toString());
    videosToDisplay = videos;
    return 'Done';
  }

  Future deleteBookmark(String id) async {
    print("reached db delete bookmark");
    var date = new DateTime.now();

    return await bookmarksCollection.doc(id).update({
      'is_deleted': true,
      'updated_on': date,
      'deleted_on': date,
    });
  }

  Future createBookmark(CustomVideo video) async {
    print("reached create bookmark");
    var date = new DateTime.now();
    bookmarksCollection.doc().set({
      'investor_id': uid,
      'entrepreneur_id': video.entrepreneurId,
      'video_id': video.id,
      'video_title': video.title,
      'video_url': video.url,
      'created_on': date,
      'is_deleted': false,
      'updated_on': date,
      'deleted_on': null,
    });
  }

  Future createConnection(String entrepreneurId) async {
    print("reached create connection");
    var date = new DateTime.now();
    connectionsCollection.doc().set({
      'investor_id': uid,
      'entrepreneur_id': entrepreneurId,
      'created_on': date,
      'is_deleted': false,
      'updated_on': date,
      'deleted_on': null,
    });
    var userData = await investorCollection.doc(uid).get();
    var currentUserData = userData.data();
    currentUser.connects = currentUserData['connects_avail'];
    investorCollection.doc(uid).update({
      'connects_avail': currentUser.connects - 1,
      'updated_on': date,
    });
  }

  updateConnectCoins(var response, var options) async {
    print("reached update connect coins");
    print('amount' + options['amount'].toString());
    int amount = options['amount'];
    int connects = 0;
    if (amount == 1000) {
      connects = 1;
    } else if (amount == 5000) {
      connects = 5;
    } else if (amount == 9500) {
      connects = 10;
    }
    var date = new DateTime.now();
    await investorCollection.doc(uid).update({
      'connects_avail': currentUser.connects + connects,
      'updated_on': date,
    });
  }

  Future checkUserInDb(String email) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    var user = await userCollection
        .where('email', isEqualTo: email)
        .where('is_deleted', isEqualTo: false)
        .get();
    if (user.docs.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future createPaymentDoc(var order) async {
    var date = new DateTime.now();
    DocumentReference docRef = await paymentCollection.add({
      'created_on': date,
      'investor_id': uid,
      'pay_initial_info': {
        'amount': json.decode(order)['amount'],
        'amount_due': json.decode(order)['amount_due'],
        'amount_paid': json.decode(order)['amount_paid'],
        'attempts': json.decode(order)['attempts'],
        'created_at': json.decode(order)['created_at'],
        'currency': json.decode(order)['currency'],
        'entity': json.decode(order)['entity'],
        'id': json.decode(order)['id'],
        'notes': json.decode(order)['notes'],
        'offer_id': json.decode(order)['offer_id'],
        'receipt': json.decode(order)['receipt'],
        'status': json.decode(order)['status'],
      },
    });
    print(docRef.id);
    paymentDocId = docRef.id;
  }

  Future updatePaymentDoc(var options) async {
    paymentCollection.doc(paymentDocId).set({
      'pay_initial_info': {
        'amount_due': 0,
        'amount_paid': options['amount'],
        'status': "paid",
      },
    }, SetOptions(merge: true));
  }

  Future updateViewsCount(String videoUrl) async {
    print("reached update views count");
    print(videoUrl);
    var videoData = await videosCollection
        .where('url', isEqualTo: videoUrl)
        .where('is_deleted', isEqualTo: false)
        .get();
    if (videoData.docs.length != 0) {
      String videoId = videoData.docs[0].id;
      print("played: " + videoId);

      if (currentUser.userType == "Investor") {
        var date = new DateTime.now();
        print("reached played - investor");
        var videoViewsData = await videoViewsCollection
            .where('video_id', isEqualTo: videoId)
            .where('user_id', isEqualTo: uid)
            .get();
        if (videoViewsData.docs.length == 0) {
          print("reached played new doc");
          videoViewsCollection.doc().set({
            'video_id': videoId,
            'user_id': uid,
            'created_on': date,
            'is_deleted': false,
            'deleted_on': null,
            'updated_on': null,
          });
          int previousViews = videoData.docs[0].data()['views_count'];
          int newViews = previousViews + 1;
          videosCollection.doc(videoId).update({
            'updated_on': date,
            'views_count': newViews,
          });
        }
      }
    }
  }
}
