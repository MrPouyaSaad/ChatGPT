import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/services/api.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getchatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, index: 0));
    notifyListeners();
  }

  Future<void> getAnswers({
    required String msg,
    required String modelID,
  }) async {
    chatList.addAll(
      await ApiServices.sendMsg(msg: msg, model: modelID),
    );
    notifyListeners();
  }
}
