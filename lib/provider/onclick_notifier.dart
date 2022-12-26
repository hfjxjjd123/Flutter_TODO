import 'package:flutter/material.dart';

OnclickNotifier onclickNotifier = OnclickNotifier();

class OnclickNotifier extends ChangeNotifier{
  int _onCount = 0;

  void onclick(){
    _onCount++;
    notifyListeners();
  }
  void offclick(){
    _onCount--;
    notifyListeners();
  }

  get count => _onCount;
}