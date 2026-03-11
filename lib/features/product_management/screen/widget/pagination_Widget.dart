import 'package:ecommerce_seller/features/product_management/provider/product_provider.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// const Color _primaryColor = Color(0xFF4361EE);
// const Color _textPrimary = Color(0xFF1A1D2E);
// const Color _textSecondary = Color(0xFF8A8D9F);
// const Color _bgColor = Color(0xFFF5F6FA);
// const Color _borderColor = Color(0xFFEEEFF4);

class PaginationBar extends StatelessWidget {
  const PaginationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13, color: AppColour.textSecondary),
                  children: [
                    const TextSpan(text: 'Showing '),
                    TextSpan(
                      text: '${provider.showingFrom} to ${provider.showingTo}',
                      style:  TextStyle(
                          fontWeight: FontWeight.w600, color: AppColour.primaryColor),
                    ),
                    TextSpan(text: ' of ${provider.totalCount} results'),
                  ],
                ),
              ),
              const Spacer(),
              _PageButton(
                label: 'Previous',
                onTap: provider.currentPage > 1
                    ? () => provider.previousPage()
                    : null,
                isText: true,
              ),
              const SizedBox(width: 6),
              for (int i = 1; i <= provider.totalPages.clamp(1, 5); i++) ...[
                _PageButton(
                  label: '$i',
                  onTap: () => provider.goToPage(i),
                  isActive: provider.currentPage == i,
                ),
                const SizedBox(width: 4),
              ],
              const SizedBox(width: 2),
              _PageButton(
                label: 'Next',
                onTap: provider.currentPage < provider.totalPages
                    ? () => provider.nextPage()
                    : null,
                isText: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PageButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isText;

  const _PageButton({
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.isText = false,
  });

  @override
  State<_PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<_PageButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null;
    return MouseRegion(
      cursor: disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: widget.isText
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 7)
              : const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
          width: widget.isText ? null : 34,
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColour.primaryColor
                : (_hovered && !disabled ? AppColour.bagroundcolorproduct : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: widget.isText ? null : Border.all(color: AppColour.borderColor),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: widget.isActive
                    ? Colors.white
                    : disabled
                        ? AppColour.textSecondary.withOpacity(0.5)
                        : AppColour.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}