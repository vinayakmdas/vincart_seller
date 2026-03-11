import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';

// const Color _electronicsBlue = Color(0xFFE8EFFE);
// const Color _electronicsTextBlue = Color(0xFF4361EE);
// const Color _fashionPurple = Color(0xFFF3EEFF);
// const Color _fashionTextPurple = Color(0xFF7B2FBE);
// const Color _defaultBg = Color(0xFFEEEFF4);
// const Color _defaultText = Color(0xFF8A8D9F);

class CategoryChip extends StatelessWidget {
  final String category;
  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Color bg, textColor;
    switch (category.toLowerCase()) {
      case 'electronics':
        bg = AppColour.electronicsBlue;
        textColor = AppColour.electronicsTextBlue;
        break;
      case 'fashion':
      case 'shoes':
        bg = AppColour.fashionPurple;
        textColor = AppColour.fashionTextPurple;
        break;
      default:
        bg = AppColour.defaultBg;
        textColor = AppColour.defaultText;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}