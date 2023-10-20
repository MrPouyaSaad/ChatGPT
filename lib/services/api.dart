import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt/constants/api_const.dart';
import 'package:chat_gpt/models/models_model.dart';
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
}
