import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/message_model.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<List<MessageModel>> getMessages({
    required String sender,
    required String receiver,
  }) {
    Stream<QuerySnapshot> stream1 = cloudMessages
        .where('sender', isEqualTo: sender)
        .where('receiver', isEqualTo: receiver)
        .orderBy('timestamp', descending: true)
        .snapshots();

    Stream<QuerySnapshot> stream2 = cloudMessages
        .where('sender', isEqualTo: receiver)
        .where('receiver', isEqualTo: sender)
        .orderBy('timestamp', descending: true)
        .snapshots();

    return Rx.combineLatest2(stream1, stream2,
            (QuerySnapshot a, QuerySnapshot b) {
          List<MessageModel> list = [];
          for (var doc in a.docs) {
            var data = doc.data() as Map<String, dynamic>?;
            var message = MessageModel.fromMap(data ?? {});
            list.add(message);
            debugPrint('Received message: ${message.text}');
          }
          for (var doc in b.docs) {
            var data = doc.data() as Map<String, dynamic>?;
            var message = MessageModel.fromMap(data ?? {});
            list.add(message);
            debugPrint('Received message: ${message.text}');
          }
          return list
            ..sort((MessageModel m1, MessageModel m2) =>
                m2.timestamp.compareTo(m1.timestamp));
        });
  }
}
