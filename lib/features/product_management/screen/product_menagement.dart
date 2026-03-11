import 'package:ecommerce_seller/features/product_management/provider/product_provider.dart';
import 'package:ecommerce_seller/features/product_management/screen/widget/productTable_widget.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// const Color _bgColor = Color(0xFFF5F6FA);
// const Color _primaryColor = Color(0xFF4361EE);

// const Color _textSecondary = Color(0xFF8A8D9F);
// const Color _borderColor = Color(0xFFEEEFF4);
// const Color _cardColor = Colors.white;

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  @override
  void initState() {
    super.initState();
    // Load products after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColour.bagroundcolorproduct,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            const Expanded(child: ProductTableCard()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            const SizedBox(height: 2),
            Text(
              'Manage your product catalog',
              style: TextStyle(fontSize: 13, color: AppColour.textSecondary),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 240,
          height: 40,
          child: TextField(
            onChanged: (v) => context.read<ProductProvider>().setSearchQuery(v),
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(color: AppColour.textSecondary, fontSize: 13),
              prefixIcon: Icon(Icons.search, size: 18, color: AppColour.textSecondary),
              filled: true,
              fillColor: AppColour.whitecolor,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColour.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColour.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColour.primaryColor, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add Product', style: TextStyle(fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColour.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}