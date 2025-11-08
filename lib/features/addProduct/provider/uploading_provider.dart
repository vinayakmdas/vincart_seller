import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/addProduct/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductUploadProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> uploadProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
      debugPrint("✅ Product uploaded successfully!");
    } catch (e) {
      debugPrint("❌ Error uploading product: $e");
      rethrow;
    }
  }
}
