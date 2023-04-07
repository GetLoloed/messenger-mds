import 'dart:async';
import 'package:flutter/widgets.dart';
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
    final timestamp = DateTime.now();
    MessageModel newMessage = MessageModel(
      id: UniqueKey().toString(),
      sender: sender,
      receiver: receiver,
      text: messageText,
      timestamp: timestamp,
    );
    await cloudMessages.add(newMessage.toMap());
  }


}
