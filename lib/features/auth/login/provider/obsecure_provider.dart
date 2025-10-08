import 'package:flutter/material.dart';

class ObscureControlling extends ChangeNotifier{

  bool  _isobcure = true;

  bool get obscure => _isobcure;

       changing (){

         _isobcure = !_isobcure;
         notifyListeners();
       }
}