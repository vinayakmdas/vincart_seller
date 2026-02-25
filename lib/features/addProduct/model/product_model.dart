import 'variant_model.dart';

class ProductModel {
  final String productId;
  final String sellerName;
  final String productName;
  final String description;
  final String brandId;
  final String categoryId;
  final String sellerId;
  final String category;
  final DateTime createdAt;
  final List<VariantModel> variants;
  final String status;
  

  ProductModel({
    required this.productId,
    required this.category,
    required this.sellerName,
    required this.productName,
    required this.description,
    required this.brandId,
    required this.categoryId,
    required this.sellerId,
    required this.createdAt,
    required this.variants,
    required this.status
  });

  Map<String, dynamic> toMap() {
    return {
      'productId' : productId,
      'category' : category,
      'sellerName': sellerName,
      'productName': productName,
      'description': description,
      'brandId': brandId,
      'categoryId': categoryId,
      'sellerId': sellerId,
      'createdAt': createdAt.toIso8601String(),
      'variants': variants.map((v) => v.toJson()).toList(),
      'status': status,
    };
  }
}
