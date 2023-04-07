import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/message_model.dart';

class MessageController {
  final CollectionReference cloudMessages =
      FirebaseFirestore.instance.collection("MESSAGES");

  Future<void> sendMessage({
    required String sender,
    required String receiver,
    required String messageText,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    await cloudMessages.add({
      'sender': sender,
      'receiver': receiver,
      'messageText': messageText,
      'timestamp': timestamp,
    });
  }

  Stream<List<MessageModel>> getMessages({
    required String sender,
    required String receiver,
  }) {
    return cloudMessages
        .where('sender', isNotEqualTo: sender)
        .where('receiver', isEqualTo: receiver)
        .orderBy('sender')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>?;
              return MessageModel.fromMap(data ?? {});
            }).toList());
  }
}
