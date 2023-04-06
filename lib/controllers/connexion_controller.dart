import 'package:firebase_auth/firebase_auth.dart';

class ConnexionController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('Adresse e-mail invalide.');
      } else if (e.code == 'user-not-found') {
        print("Aucun utilisateur trouvé avec cette adresse e-mail.");
      } else if (e.code == 'wrong-password') {
        print("Mot de passe incorrect.");
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
