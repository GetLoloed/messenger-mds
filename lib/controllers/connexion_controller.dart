import 'package:firebase_auth/firebase_auth.dart';

class ConnexionController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Erreur lors de la connexion: $e');
      return null;
    } catch (e) {
      print('Erreur inconnue lors de la connexion: $e');
      return null;
    }
  }
}
