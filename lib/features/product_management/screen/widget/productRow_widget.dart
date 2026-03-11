import 'package:ecommerce_seller/features/product_management/model/product_model.dart';
import 'package:ecommerce_seller/features/product_management/provider/product_provider.dart';
import 'package:ecommerce_seller/features/product_management/screen/widget/action_icon_widget.dart';
import 'package:ecommerce_seller/features/product_management/screen/widget/category_widget.dart';
import 'package:ecommerce_seller/features/product_management/screen/widget/status_badge.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// const Color _bgColor = Color(0xFFF5F6FA);
// const Color _textPrimary = Color(0xFF1A1D2E);
// const Color _textSecondary = Color(0xFF8A8D9F);

class ProductRow extends StatelessWidget {
  final ProductModels product;
  final String slNo;
  final int index;

  const ProductRow({
    super.key,
    required this.product,
    required this.slNo,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // SL NO
          Expanded(
            flex: 1,
            child: Text(slNo,
                style: TextStyle(
                    fontSize: 13,
                    color: AppColour.textPrimary,
                    fontWeight: FontWeight.w500)),
          ),
          // Product name + image
          Expanded(
            flex: 5,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.thumbnailUrl.isNotEmpty
                      ? Image.network(
                          product.thumbnailUrl,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    product.productName,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColour.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Brand
          Expanded(
            flex: 2,
            child: Text(product.brandId,
                style: TextStyle(fontSize: 13, color: AppColour.textSecondary)),
          ),
          // Category
          Expanded(
            flex: 2,
            child: CategoryChip(category: product.category),
          ),
          // Status
          Expanded(
            flex: 2,
            child: StatusBadge(isActive: product.isActive),
          ),
          // Actions
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionIconButton(
                  icon: Icons.visibility_outlined,
                  onTap: () {/* Navigate to detail */},
                ),
                const SizedBox(width: 8),
                ActionIconButton(
                  icon: Icons.edit_outlined,
                  onTap: () {/* Navigate to edit */},
                ),
                const SizedBox(width: 8),
                ActionIconButton(
                  icon: Icons.delete_outline,
                  isDelete: true,
                  onTap: () => _confirmDelete(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColour.bagroundcolorproduct,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.image_outlined, color: AppColour.textSecondary, size: 20),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.productName}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProductProvider>().deleteProduct(product.productId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}