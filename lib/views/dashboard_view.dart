import 'package:flutter/material.dart';
import 'package:messenger/controllers/connexion_controller.dart';
import 'package:messenger/controllers/user_controller.dart';
import 'package:messenger/models/user_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final UserController _userController = UserController();
  final ConnexionController _connexionController = ConnexionController();
  late Future<UserModel> _currentUserFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentUserFuture = _userController.getUserData();
  }

  void _signOut() async {
    await _connexionController.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _signOut();
      }
    });
  }

  Widget _buildProfile(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: user.avatar != null
                ? NetworkImage(user.avatar!)
                : null,
            radius: 30,
          ),
          const SizedBox(height: 8),
          Text('Prénom: ${user.firstName}'),
          Text('Nom: ${user.lastName}'),
          Text('Pseudo: ${user.username}'),
          Text('Email: ${user.email}'),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Messages:'),
          // Insérez ici le widget qui affiche les messages
        ],
      ),
    );
  }

  List<Widget> _buildScreens(UserModel user) {
    return [
      _buildProfile(user),
      _buildMessages(),
      const SizedBox.shrink(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder<UserModel>(
        future: _currentUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }

            final user = snapshot.data!;
            return _buildScreens(user)[_selectedIndex];
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Déconnexion',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
