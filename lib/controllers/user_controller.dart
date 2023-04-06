import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getUsersExceptCurrentUser() async {
    List<Map<String, dynamic>> usersList = [];

    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final querySnapshot = await _firestore.collection('users').get();

        for (var doc in querySnapshot.docs) {
          if (doc.id != currentUser.uid) {
            usersList.add(doc.data());
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return usersList;
  }
}
