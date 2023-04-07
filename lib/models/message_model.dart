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
  })  : assert(id.isNotEmpty, 'Le champ "id" ne doit pas être vide'),
        assert(sender.isNotEmpty, 'Le champ "sender" ne doit pas être vide'),
        assert(
            receiver.isNotEmpty, 'Le champ "receiver" ne doit pas être vide'),
        assert(text.isNotEmpty, 'Le champ "text" ne doit pas être vide');

  // Utiliser pour convertir un Map (par exemple, depuis une base de données) en objet Message
  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      id: data['id'] ?? '',
      sender: data['sender'] ?? '',
      receiver: data['receiver'] ?? '',
      text: data['text'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
    );
  }

  // Utiliser pour convertir un objet Message en Map (par exemple, pour l'enregistrer dans une base de données)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
