import 'package:flutter/material.dart';

class SignupLoading  extends ChangeNotifier{

  bool _isloading = false;

   
   bool get  isloading => _isloading;


    void start(){

      _isloading =true;
      notifyListeners();
    }

   void stop (){
    _isloading= false ;

    notifyListeners();
   }
} 