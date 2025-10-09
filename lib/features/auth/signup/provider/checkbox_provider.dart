import 'package:flutter/material.dart';

class CheckboxProvider  extends ChangeNotifier{

  bool _ischeck=false;

  bool get ischeck  => _ischeck;


  changing(bool? value){

    _ischeck = value ?? false;
    notifyListeners();
  }
}