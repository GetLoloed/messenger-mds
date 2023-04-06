import 'package:flutter/material.dart';
import 'package:messenger/controllers/inscription_controller.dart';
import 'package:messenger/models/user_model.dart';

class InscriptionView extends StatefulWidget {
  const InscriptionView({super.key});

  @override
  _InscriptionViewState createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final FirestoreHelper _firestoreHelper = FirestoreHelper();

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String username = _usernameController.text;

    try {
      UserModel user = await _firestoreHelper.signUp(
        email,
        password,
        firstName,
        lastName,
        username,
      );
      print("Utilisateur créé avec succès: ${user.firstName} ${user.lastName}");
      // Naviguez vers la page d'accueil ou la page suivante après la création du compte.
    } catch (e) {
      print("Erreur lors de la création du compte: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
