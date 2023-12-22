import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/Model/Notes_Model.dart';
import 'package:uuid/uuid.dart';

class FireStore_DataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> AddNote(String subTitle, String title, int tagIndex) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = new DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'title': title,
        'subTitle': subTitle,
        'time': '${data.hour}:${data.minute}',
        'tagIndex': tagIndex,
        'isDone': false,
      });
      return true;
    } catch (e) {
      print('Hata Kod: 1 -> ' + e.toString());
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['title'],
          data['subTitle'],
          data['time'],
          data['tagIndex'],
          data['isDone'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      print('Hata Kod: 2 -> ' + e.toString());
      return [];
    }
  }

  Stream<QuerySnapshot> stream() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .snapshots();
  }

  Future<bool> isTaskDone(String userUid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(userUid)
          .update({'isDone': isDone});
      return true;
    } catch (e) {
      print('Hata Kod: 3 -> ' + e.toString());
      return true;
    }
  }

  Future<bool> UpdateNote(String userUid, int tagIndex, String title,
      String subTitle) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(userUid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subTitle': subTitle,
        'title': title,
        'tagIndex': tagIndex,
      });
      return true;
    } catch (e) {
      print('Hata Kod: 4 -> ' + e.toString());
      return true;
    }
  }

  Future<bool> DeleteNote(String userUid) async {
    try {
      await _firestore.collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes').doc(userUid).delete();
      return true;
    }
    catch (e) {
      print('Hata Kod: 5 ->' + e.toString());
      return true;
    }
  }
}
