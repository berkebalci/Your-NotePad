import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreOperations {
  Future isThisUsersFirstNote(String userUniqueId) async {
    //Kullanicinin unique id'sinde bir collection var mı onu kontrol ediyoruz.
    //Firestore'da document olmadan tek başına collection oluşturulamıyor.

    CollectionReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc('$userUniqueId')
        .collection('note1'); //Buranın düzeltilmesi lazım
    var isCollectExists = await userRef.get().then((value) => value.size > 0);
    print(isCollectExists);
    return isCollectExists;
  }

  //TODO: 
}
