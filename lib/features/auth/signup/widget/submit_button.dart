import 'package:ecommerce_seller/theme/app_custome_colour.dart';

import 'package:flutter/material.dart';

class Button {
  // Gradient Rectangle Button (supports child widget)
  static Widget rectangleButton({
    required Widget child,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColour.purplePinkGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
