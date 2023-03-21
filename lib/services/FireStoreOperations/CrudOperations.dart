import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_app_firebase/services/models/Note.dart';

class FireStoreCrudOperations {
  Future createNote(
      String docname, String title, String content, String userUID) async {
    final docNote =
        FirebaseFirestore.instance.collection('users').doc('$docname');
    final note = Note(title: title, content: content, userUID: userUID);
    final json = note.toJson();
    docNote.set(json);
  }

  Stream<List<Note>> readNotes(String currentUseremail) {
    //Bu stream yapısından zaten asenkron olduğundan dolayı async* keywordunu kullanmamız gerekiyor.
    return FirebaseFirestore.instance
        .collection('users')
        .doc('$currentUseremail')
        .collection('note1')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) => Note.fromJson(docs.data())).toList();
    });

    //Dökümanların datalarını döndürüyor
  }
}
