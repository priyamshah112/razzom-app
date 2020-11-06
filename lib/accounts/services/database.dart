import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razzom/accounts/models/customUser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference entrepreneurCollection =
      FirebaseFirestore.instance.collection('entrepreneur');
  final CollectionReference investorCollection =
      FirebaseFirestore.instance.collection('investor');

  Future createUserData(CustomUser user) async {
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
}
