import 'package:flutter/material.dart';
import 'package:messenger/controllers/connexion_controller.dart';

class ConnexionView extends StatefulWidget {
  const ConnexionView({Key? key}) : super(key: key);

  @override
  _ConnexionViewState createState() => _ConnexionViewState();
}

class _ConnexionViewState extends State<ConnexionView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ConnexionController _connexionController = ConnexionController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un e-mail';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Veuillez entrer un e-mail valide";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _emailValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: _passwordValidator,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final userCredential = await _connexionController.signIn(email, password);
                    if (userCredential != null) {
                      // Rediriger vers la page du tableau de bord
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    } else {
                      // Afficher un message d'erreur ou une boîte de dialogue
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Echec de la connexion')),
                      );
                    }
                  }
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
