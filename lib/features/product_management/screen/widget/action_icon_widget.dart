import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';

// const Color _bgColor = Color(0xFFF5F6FA);
// const Color _primaryColor = Color(0xFF4361EE);
// const Color _inactiveRed = Color(0xFFE63946);
// const Color _textSecondary = Color(0xFF8A8D9F);
// const Color _borderColor = Color(0xFFEEEFF4);

class ActionIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDelete;

  const ActionIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.isDelete = false,
  });

  @override
  State<ActionIconButton> createState() => _ActionIconButtonState();
}

class _ActionIconButtonState extends State<ActionIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: _hovered
                ? (widget.isDelete
                    ? AppColour.inactiveRed .withOpacity(0.08)
                    : AppColour.primaryColor.withOpacity(0.07))
                : AppColour.bagroundcolorproduct,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColour.borderColor),
          ),
          child: Icon(
            widget.icon,
            size: 16,
            color: _hovered
                ? (widget.isDelete ? AppColour.inactiveRed : AppColour.primaryColor)
                : AppColour.textSecondary,
          ),
        ),
      ),
    );
  }
}