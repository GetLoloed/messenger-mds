import 'package:flutter/material.dart';
import 'views/accueil_view.dart';
import 'views/connexion_view.dart';
import 'views/inscription_view.dart'; // importez votre vue d'inscription ici

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messagerie',
      initialRoute: '/',
      routes: {
        '/': (context) => AccueilView(),
        '/connexion': (context) => const ConnexionView(),
        '/inscription': (context) => const InscriptionView(), // définir la route d'inscription
      },
    );
  }
}
