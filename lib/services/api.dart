import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt/constants/api_const.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<Models>> getModels() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/models'),
          headers: {'Authorization': ' Bearer $apiKey'});
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List temp = [];
      for (var i in jsonResponse['data']) {
        temp.add(i);
      }
      return Models.modelsList(temp);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  // Send msg

  static Future<List<ChatModel>> sendMsg(
      {required String msg, required String model}) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": model,
          "messages": [
            {
              "role": "user",
              "content": msg,
            }
          ],
          "temperature": 0.7,
        }),
      );
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw Exception("error: ${jsonResponse['error']['message']}");
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        debugPrint(
            'response: ${jsonResponse['choices'][0]['message']['content']}');
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
              msg: jsonResponse['choices'][index]['message']['content'],
              index: 1),
        );
      }
      return chatList;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
