import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/user_model.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("L'utilisateur n'est pas connecté");
    }

    final documentSnapshot =
        await _firestore.collection('UTILISATEURS').doc(user.uid).get();
    if (!documentSnapshot.exists) {
      throw Exception("Les données de l'utilisateur n'ont pas été trouvées");
    }

    return UserModel.fromMap(documentSnapshot.data()!);
  }

  Future<List<UserModel>> getAllUsersExceptCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("L'utilisateur n'est pas connecté");
    }

    final querySnapshot = await _firestore.collection('UTILISATEURS').get();
    List<UserModel> users = [];

    for (var doc in querySnapshot.docs) {
      if (doc.id != currentUser.uid) {
        users.add(UserModel.fromMap(doc.data()));
      }
    }

    return users;
  }
}
