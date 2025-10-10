
import 'dart:async';
import 'package:ecommerce_seller/features/auth/login/screens/webviewlogin/webLogin.dart';
import 'package:ecommerce_seller/features/drawer/screen/drawerScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
 
class _SplashScreenState extends State<SplashScreen> {


Timer? _timer;

@override
void initState() {
  super.initState();
  _timer = Timer(const Duration(seconds: 3), checkinglogin);
}

@override
void dispose() {
  _timer?.cancel(); // cancel timer when leaving screen
  super.dispose();
}

  @override


  Widget build(BuildContext context) {
 
    return const Scaffold(
      
      body: Center(
        child: Text("this is the splash screen"),
      ),
      
    );
  }
 checkinglogin()async{

   final  SharedPreferences pref =await SharedPreferences.getInstance();

  String ? email =   pref.getString("email");
  String ?password = pref.getString("password");
  
     if (!mounted) return; 
   if(email != null && password !=null){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    
   }else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebLoginScreen()));
   }

 
  }
}