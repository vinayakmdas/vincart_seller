import 'package:ecommerce_seller/features/addProduct/custome/publish_product.dart';
import 'package:ecommerce_seller/features/addProduct/provider/branList_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/category_provider.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  @override
  void initState() {
    super.initState();
    // 🟢 Fetch category and brand data when the screen opens
    Future.microtask(() {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.fetchCategories();

      final brandProvider =
          Provider.of<BrandListProvider>(context, listen: false);
      brandProvider.fetchBrands(); // call your brand fetch function
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColour.scaffoldBgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AddproduictCustome.publishButton(context),
              AddproduictCustome.requiredProductDetails(context),
            ],
          ),
        ),
      ),
    );
  }
}
