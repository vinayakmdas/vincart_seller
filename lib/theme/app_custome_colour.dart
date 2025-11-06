import 'package:flutter/material.dart';

class AppColour{


static const whitecolor = Colors.white;
  static const Color purple700 = Color(0xFF6B21A8);
  static const Color pink500   = Color(0xFFEC4899);
  static const Color scaffoldBgColor = Color(0xFFF6F6F8);
  static const Color blackcolor = Colors.black;
    static const Color greycolor = Colors.grey;
  // 🎨 Gradient (bg-gradient-to-r from-purple-700 to-pink-500)
  static const LinearGradient purplePinkGradient = LinearGradient(
    colors: [purple700, pink500],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
    
}