import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../repositories/chat_repository.dart';

class ChatProvider extends ChangeNotifier {

  final ChatRepository _chatRepository = ChatRepository();

  final List<Message> _chatMessages = [];

  List<Message> get chatMessages => _chatMessages;

  Future<void> sendMessage ({required String userMessage}) async {

    _chatMessages.add(Message(content: userMessage, role: 'user'));
    _chatMessages.add(Message(content: 'Typing...', role: 'assistant'));
    notifyListeners();

    final assistantMenssage = await _chatRepository.sendMessageAndGetResponse(chatMessages: _chatMessages);

    _chatMessages.removeLast();
    _chatMessages.add(assistantMenssage);
    notifyListeners();

  }
  
}