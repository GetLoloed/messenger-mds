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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const AccueilView());
          case '/connexion':
            return MaterialPageRoute(
                builder: (context) => const ConnexionView());
          case '/inscription':
            return MaterialPageRoute(
                builder: (context) => const InscriptionView());
          case '/dashboard':
            return MaterialPageRoute(
                builder: (context) => const DashboardView());
          case '/message':
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
                builder: (context) => MessageView(
                  user1Id: args['user1Id']!,
                  user2Id: args['user2Id']!,
                ));
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
