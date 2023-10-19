import 'dart:convert';
import 'dart:io';

import 'package:chat_gpt/constants/api_const.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<void> getModels() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/model'),
          headers: {'Authorization': ' Bearer $apiKey'});
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse == 'error') {
        throw HttpException(jsonResponse['error']['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
