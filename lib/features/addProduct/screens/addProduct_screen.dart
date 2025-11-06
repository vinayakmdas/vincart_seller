import 'package:ecommerce_seller/features/addProduct/custome/publish_product.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatelessWidget {
  const Addproduct({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColour.scaffoldBgColor ,
      body: Center(
        child: Column(
          children: [
        AddproduictCustome.publishButton(),
       
        AddproduictCustome.requiredProductDetails(context)

          ],
        )
    )
    );
  }
}