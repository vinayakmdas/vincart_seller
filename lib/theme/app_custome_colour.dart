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

  // product management 

 static const Color bagroundcolorproduct = Color(0xFFF5F6FA);
 static const Color primaryColor = Color(0xFF4361EE);
 static const Color textPrimary = Color(0xFF1A1D2E);
 static const Color textSecondary = Color(0xFF8A8D9F);
 static const Color activeGreen = Color(0xFF2DC653);
 static const Color inactiveRed = Color(0xFFE63946);
 static const Color electronicsBlue = Color(0xFFE8EFFE);
 static const Color electronicsTextBlue = Color(0xFF4361EE);
 static const Color fashionPurple = Color(0xFFF3EEFF);
 static const Color fashionTextPurple = Color(0xFF7B2FBE);
 static const Color borderColor = Color(0xFFEEEFF4);
 static const Color defaultBg = Color(0xFFEEEFF4);
 static  const Color defaultText = Color(0xFF8A8D9F);

    
}