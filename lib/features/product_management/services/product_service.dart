import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/addProduct/model/product_model.dart';
import 'package:ecommerce_seller/features/product_management/model/product_model.dart';


class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'products';

  /// Fetch all products (one-time fetch)
  Future<List<ProductModels>> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs
          .map((doc) => ProductModels.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  /// Real-time stream of products
  Stream<List<ProductModels>> productsStream() {
    return _firestore.collection(_collection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModels.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Delete a product by document ID
  Future<void> deleteProduct(String productId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}