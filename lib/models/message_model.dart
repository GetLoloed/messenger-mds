import 'user_model.dart';

class Message {
  final String id;
  final UserModel sender;
  final String recipientId;
  final String text;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.sender,
    required this.recipientId,
    required this.text,
    required this.timestamp,
  });

  // Utiliser pour convertir un Map (par exemple, depuis une base de données) en objet Message
  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      id: data['id'],
      sender: UserModel.fromMap(data['sender']),
      recipientId: data['recipientId'],
      text: data['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }
}
