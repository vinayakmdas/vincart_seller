
// import 'package:ecommerce_seller/features/auth/signup/screens/webviewSignUp/webviewSignUp.dart';
import 'package:ecommerce_seller/features/auth/login/provider/obsecure_provider.dart';
import 'package:ecommerce_seller/features/auth/login/screens/webviewlogin/webLogin.dart';
import 'package:ecommerce_seller/features/auth/login/widget/login%20loading.dart';
import 'package:ecommerce_seller/features/auth/signup/provider/dropdown_provider.dart';
import 'package:ecommerce_seller/features/auth/signup/provider/signup_loading.dart';
import 'package:ecommerce_seller/features/drawer/provider/drawer_provider.dart';
import 'package:ecommerce_seller/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
try {
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
} catch (e) {
  print("error is $e");
}
 

  runApp(
   
  
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_)=>DropdownProvider()),
           ChangeNotifierProvider(create: (_)=> SignupLoading()),
        ChangeNotifierProvider(create: (_)=>LoadingProvider()),
        ChangeNotifierProvider(create: (_)=>ObscureControlling()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        // add more providers here if needed
        
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: WebLoginScreen(),
      // home:  WebViewSignUp(),
      // home:  WaitingScreen(),
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     
    );
  }
}
