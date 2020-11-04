import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razzom/accounts/models/customUser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference entrepreneurCollection =
      FirebaseFirestore.instance.collection('entrepreneur');
  final CollectionReference investorCollection =
      FirebaseFirestore.instance.collection('investor');

  Future createUserData(CustomUser user) async {
    if (user.userType == "E") {
      return await entrepreneurCollection.doc(uid).set({
        'name': user.name,
        'phone_no': user.phone,
        'whatsapp_no': user.whatsapp,
        'email': user.email,
        'location': user.location,
        'industry': user.entrepreneurOffering,
        'funding_required': user.funding,
        'created_on': null,
        'is_deleted': false,
        'updated_on': null,
        'deleted_on': null,
      });
    } else if (user.userType == "I") {
      return await investorCollection.doc(uid).set({
        'name': user.name,
        'phone_no': user.phone,
        'whatsapp_no': user.whatsapp,
        'email': user.email,
        'location': user.location,
        'investor_type': user.investorType,
        'budget': user.funding,
        'connects_avail': 0,
        'intro': "",
        'created_on': null,
        'is_deleted': false,
        'updated_on': null,
        'deleted_on': null,
      });
    }
  }
}
