import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../providers/chat_provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final TextEditingController _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ChatGPT'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Provider.of<ChatProvider>(context).chatMessages.isNotEmpty
                ? ListView.builder(
                    itemCount:
                        Provider.of<ChatProvider>(context).chatMessages.length,
                    itemBuilder: (context, index) {
                      final Message message =
                          Provider.of<ChatProvider>(context, listen: false)
                              .chatMessages[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: message.role == 'user'
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: message.role == 'user'
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.blueGrey[900],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.role,
                                    style:
                                        const TextStyle(color: Colors.white30),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(message.content),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('Send a message to start a new chat.'),
                  ),
          ),
          Container(
            height: 120.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 26, 26, 26),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, -5),
                    blurRadius: 10.0,
                    color: Colors.black38)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(
                        label: const Text('What do you want to know?'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed: () {
                    Provider.of<ChatProvider>(context, listen: false)
                        .sendMessage(userMessage: _messageTextController.text);

                    _messageTextController.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
