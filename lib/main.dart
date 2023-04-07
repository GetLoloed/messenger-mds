import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger/views/accueil_view.dart';
import 'package:messenger/views/connexion_view.dart';
import 'package:messenger/views/inscription_view.dart';
import 'package:messenger/views/dashboard_view.dart';
import 'package:messenger/views/messages_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/': (context) => const AccueilView(),
        '/connexion': (context) => const ConnexionView(),
        '/inscription': (context) => const InscriptionView(),
        '/dashboard': (context) => const DashboardView(),
        '/message': (context) => const MessageView(),
      },
    );
  }
}
