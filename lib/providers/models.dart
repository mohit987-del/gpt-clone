import 'package:cxw7/services/api_serv.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  List _modelsList = [];
  String _current = "gpt-3.5-turbo-0301";
  List get getModel{
    return _modelsList;
  }
  String get getCurrent{
    return _current;
  }
  void setCurrent(String model){
    _current = model;
    notifyListeners();
  }
  Future<List> getAllModels() async{
    _modelsList = await ApiService.getModels();
    return _modelsList;
  }
}