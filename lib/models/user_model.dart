class User {
  late String id;
  late String firstName;
  late String lastName;
  late String username;
  late String email;
  String? avatar;

  User({
    required,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.avatar,
  });

  // Utiliser pour convertir un Map (par exemple, depuis une base de données) en objet User
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      username: data['username'],
      email: data['email'],
      avatar: data['avatar'],
    );
  }

  // Utiliser pour convertir un objet User en Map (par exemple, pour stocker dans une base de données)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'avatar': avatar,
    };
  }
}
