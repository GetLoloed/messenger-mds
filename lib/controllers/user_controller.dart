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

    final documentSnapshot = await _firestore.collection('users').doc(user.uid).get();
    if (!documentSnapshot.exists) {
      throw Exception("Les données de l'utilisateur n'ont pas été trouvées");
    }

    return UserModel.fromMap(documentSnapshot.data()!);
  }
}
