import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/services/api.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  String currentlyModel = 'gpt-3.5-turbo';

  String get getCurrentlyModel {
    return currentlyModel;
  }

  void set setCurrentlyModel(String newModel) {
    currentlyModel = newModel;
    notifyListeners();
  }

  List<Models> modelsList = [];

  List<Models> get getModelsList {
    return modelsList;
  }

  Future<List<Models>> getAllModels() async {
    modelsList = await ApiServices.getModels();
    return modelsList;
  }
}
