import 'package:flutter/material.dart';
import 'package:messenger/controllers/message_controller.dart';
import 'package:messenger/models/message_model.dart';

class MessageView extends StatelessWidget {
  const MessageView({Key? key, required this.user1Id, required this.user2Id})
      : super(key: key);

  final String user1Id;
  final String user2Id;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final MessageController messageController = MessageController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: messageController.getMessages(
                sender: user1Id,
                receiver: user2Id,
              ),
              builder: (BuildContext context, AsyncSnapshot<List<MessageModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  debugPrint('Received 0 messages');
                  return Center(
                    child: Text('Aucun message avec $user2Id'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      final MessageModel message = snapshot.data![index];
                      final bool isSentByMe = message.sender == user1Id;

                      return Row(
                        mainAxisAlignment: isSentByMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: isSentByMe
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: isSentByMe
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  message.timestamp.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: isSentByMe
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Entrez votre message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (textController.text.isNotEmpty) {
                      await messageController.sendMessage(
                        sender: user1Id,
                        receiver: user2Id,
                        messageText: textController.text,
                      );
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
