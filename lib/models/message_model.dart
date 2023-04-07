import 'user_model.dart';

class MessageModel {
  final String id;
  final String sender;
  final String receiver;
  final String text;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.timestamp,
  });

  // Utiliser pour convertir un Map (par exemple, depuis une base de données) en objet Message
  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      id: data['id'],
      sender: data['sender'],
      receiver: data['receiver'],
      text: data['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }
}
