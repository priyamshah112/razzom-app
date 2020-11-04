import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference entrepreneurCollection =
      FirebaseFirestore.instance.collection('entrepreneur');

  Future updateUserData(
      String name, String phone, String whatsapp, String email) async {
    print(email);
    return await entrepreneurCollection.doc(uid).set({
      'name': name,
      'phone_no': phone,
      'whatsapp_no': whatsapp,
      'email': email,
    });
  }
}
