import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
    final List<Choice> choices;
    final int created;
    final String id;
    final String model;
    final String object;
    final Usage usage;

    ChatModel({
        required this.choices,
        required this.created,
        required this.id,
        required this.model,
        required this.object,
        required this.usage,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        created: json["created"],
        id: json["id"],
        model: json["model"],
        object: json["object"],
        usage: Usage.fromJson(json["usage"]),
    );

    Map<String, dynamic> toJson() => {
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "created": created,
        "id": id,
        "model": model,
        "object": object,
        "usage": usage.toJson(),
    };
}

class Choice {
    final String finishReason;
    final int index;
    final Message message;

    Choice({
        required this.finishReason,
        required this.index,
        required this.message,
    });

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        finishReason: json["finish_reason"],
        index: json["index"],
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "finish_reason": finishReason,
        "index": index,
        "message": message.toJson(),
    };
}

class Message {
    final String content;
    final String role;

    Message({
        required this.content,
        required this.role,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "role": role,
    };
}

class Usage {
    final int completionTokens;
    final int promptTokens;
    final int totalTokens;

    Usage({
        required this.completionTokens,
        required this.promptTokens,
        required this.totalTokens,
    });

    factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        completionTokens: json["completion_tokens"],
        promptTokens: json["prompt_tokens"],
        totalTokens: json["total_tokens"],
    );

    Map<String, dynamic> toJson() => {
        "completion_tokens": completionTokens,
        "prompt_tokens": promptTokens,
        "total_tokens": totalTokens,
    };
}
