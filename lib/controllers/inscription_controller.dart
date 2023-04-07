import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final CollectionReference cloudUsers =
      FirebaseFirestore.instance.collection("UTILISATEURS");
  final CollectionReference cloudMessages =
      FirebaseFirestore.instance.collection("MESSAGES");

  Future<UserModel> signUp(String email, String password, String firstName,
      String lastName, String username,
      {String? avatar}) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("Erreur lors de la création de l'utilisateur");
    } else {
      String uid = user.uid;
      Map<String, dynamic> map = {
        'id': uid,
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'avatar': avatar,
      };
      addUser(uid, map);
      return getUser(uid);
    }
  }

  Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await cloudUsers.doc(id).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<UserModel> signIn(String email, String password) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("Erreur lors de la connexion de l'utilisateur");
    } else {
      String uid = user.uid;
      return getUser(uid);
    }
  }

  void addUser(String id, Map<String, dynamic> map) {
    cloudUsers.doc(id).set(map);
  }

  void updateUser(String id, Map<String, dynamic> data) {
    cloudUsers.doc(id).update(data);
  }

  Future<String> storeImage(
      {required String folder,
      required String personalFolder,
      required String imageName,
      required Uint8List imageData}) async {
    String url = "";
    TaskSnapshot taskSnapshot = await storage
        .ref("$folder/$personalFolder/$imageName")
        .putData(imageData);
    url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
