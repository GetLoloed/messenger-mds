import 'package:flutter/material.dart';
import 'package:messenger/controllers/message_controller.dart';
import 'package:messenger/models/message_model.dart';

class MessageView extends StatelessWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final user1Id = args['user1Id'];
    final user2Id = args['user2Id'];

    final TextEditingController _textController = TextEditingController();
    final MessageController _messageController = MessageController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _messageController.getMessages(
                  receiver: user1Id!, sender: user2Id!),
              builder: (BuildContext context,
                  AsyncSnapshot<List<MessageModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
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
                                vertical: 4.0, horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: isSentByMe
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16.0),
                                topRight: const Radius.circular(16.0),
                                bottomLeft: isSentByMe
                                    ? const Radius.circular(16.0)
                                    : Radius.zero,
                                bottomRight: isSentByMe
                                    ? Radius.zero
                                    : const Radius.circular(16.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isSentByMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
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
                    controller: _textController,
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
                    if (_textController.text.isNotEmpty) {
                      await _messageController.sendMessage(
                        sender: user1Id,
                        receiver: user2Id,
                        messageText: _textController.text,
                      );
                      _textController.clear();
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
