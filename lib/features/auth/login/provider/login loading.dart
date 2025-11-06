
import 'package:flutter/widgets.dart';

class LoadingProvider extends ChangeNotifier{


  bool _loading = false;

    bool  get isloading =>  _loading;

 void  start(){

  _loading = true;
  notifyListeners();
}

void stop(){

  _loading = false;
  notifyListeners();
}
}