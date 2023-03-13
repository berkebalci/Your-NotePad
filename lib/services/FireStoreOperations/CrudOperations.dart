import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int note_count = 0;

class CrudOperations {
  String title;
  String content;
  CrudOperations(this.title, this.content);

  Future createNote(String title, String content) async {
    
  }
}
