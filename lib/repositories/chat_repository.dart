import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/chat_model.dart';
import '../utils/api_util.dart';

class ChatRepository {
  Future<Message> sendMessageAndGetResponse(
      {required List<Message> chatMessages}) async {
    try {
      final apiUri = Uri.parse(ApiUtil.baseUrl);

      final chatJson = chatMessages.map((message) => message.toJson()).toList();

      final response = await http.post(apiUri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${ApiUtil.apiKey}',
          },
          body: jsonEncode({
            'model': 'gpt-3.5-turbo',
            'messages': chatJson,
          }));

      if (response.statusCode == 200) {
        final chatResponse = chatModelFromJson(utf8.decode(response.bodyBytes));

        return chatResponse.choices[0].message;
      } else {
        return Future.error(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
