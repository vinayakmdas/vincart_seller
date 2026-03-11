import 'package:ecommerce_seller/features/product_management/provider/product_provider.dart';
import 'package:ecommerce_seller/features/product_management/screen/widget/pagination_Widget.dart';
import 'package:ecommerce_seller/features/product_management/screen/widget/productRow_widget.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// const Color _cardColor = Colors.white;
// const Color _borderColor = Color(0xFFEEEFF4);
// const Color _textSecondary = Color(0xFF8A8D9F);
// const Color _bgColor = Color(0xFFF5F6FA);

class ProductTableCard extends StatelessWidget {
  const ProductTableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        if (provider.state == ProductLoadState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.state == ProductLoadState.error) {
          return Center(
            child: Text('Error: ${provider.errorMessage}',
                style: const TextStyle(color: Colors.red)),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: AppColour.whitecolor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColour.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildTableHeader(),
               Divider(height: 1, color: AppColour.borderColor),
              Expanded(
                child: provider.pagedProducts.isEmpty
                    ? Center(
                        child: Text('No products found.',
                            style: TextStyle(color: AppColour.textSecondary)))
                    : ListView.separated(
                        itemCount: provider.pagedProducts.length,
                        separatorBuilder: (_, __) =>  Divider(
                            height: 1,
                            color: AppColour.borderColor,
                            indent: 20,
                            endIndent: 20),
                        itemBuilder: (context, index) {
                          final product = provider.pagedProducts[index];
                          final slNo =
                              ((provider.currentPage - 1) * provider.itemsPerPage +
                                      index +
                                      1)
                                  .toString()
                                  .padLeft(2, '0');
                          return ProductRow(
                              product: product, slNo: slNo, index: index);
                        },
                      ),
              ),
               Divider(height: 1, color: AppColour.borderColor),
              const PaginationBar(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          _headerCell('SL NO', flex: 1),
          _headerCell('PRODUCT', flex: 5),
          _headerCell('BRAND', flex: 2),
          _headerCell('CATEGORY', flex: 2),
          _headerCell('STATUS', flex: 2),
          _headerCell('ACTIONS', flex: 2, align: TextAlign.right),
        ],
      ),
    );
  }

  Widget _headerCell(String label, {int flex = 1, TextAlign align = TextAlign.left}) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        textAlign: align,
        style:  TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color:AppColour.textSecondary ,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}