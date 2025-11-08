import 'variant_model.dart';

class ProductModel {
  final String productName;
  final String description;
  final String brandId;
  final String categoryId;
  final String sellerId;
  final DateTime createdAt;
  final List<VariantModel> variants;

  ProductModel({
    required this.productName,
    required this.description,
    required this.brandId,
    required this.categoryId,
    required this.sellerId,
    required this.createdAt,
    required this.variants,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'brandId': brandId,
      'categoryId': categoryId,
      'sellerId': sellerId,
      'createdAt': createdAt.toIso8601String(),
      'variants': variants.map((v) => v.toJson()).toList(),
    };
  }
}
