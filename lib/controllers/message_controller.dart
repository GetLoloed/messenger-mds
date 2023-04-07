import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/message_model.dart';

class MessageController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getConversationId(String sender, String receiver) {
    return (sender.compareTo(receiver) < 0)
        ? sender + '_' + receiver
        : receiver + '_' + sender;
  }

  Future<void> sendMessage({
    required String sender,
    required String receiver,
    required String messageText,
  }) async {
    final timestamp = DateTime.now();
    final conversationId = _getConversationId(sender, receiver);
    MessageModel newMessage = MessageModel(
      id: UniqueKey().toString(),
      sender: sender,
      receiver: receiver,
      text: messageText,
      timestamp: timestamp,
    );
    await _firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<List<MessageModel>> getMessages({
    required String sender,
    required String receiver,
  }) {
    final conversationId = _getConversationId(sender, receiver);

    return _firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data()))
          .toList();
    });
  }
}
