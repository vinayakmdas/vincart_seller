
import 'package:ecommerce_seller/features/product_management/model/product_variant.dart';

class ProductModels {
  final String productId;
  final String productName;
  final String brandId;
  final String category;
  final String categoryId;
  final String description;
  final String sellerId;
  final String sellerName;
  final String status;
  final String createdAt;
  final List<ProductVariant> variants;

  const ProductModels({
    required this.productId,
    required this.productName,
    required this.brandId,
    required this.category,
    required this.categoryId,
    required this.description,
    required this.sellerId,
    required this.sellerName,
    required this.status,
    required this.createdAt,
    required this.variants,
  });

  bool get isActive => status.toLowerCase() == 'active';

  /// First image of first variant, used as thumbnail
  String get thumbnailUrl =>
      variants.isNotEmpty && variants.first.images.isNotEmpty
          ? variants.first.images.first
          : '';

  factory ProductModels.fromMap(Map<String, dynamic> map) {
    final variantsList = (map['variants'] as List<dynamic>? ?? [])
        .map((v) => ProductVariant.fromMap(Map<String, dynamic>.from(v)))
        .toList();

    return ProductModels(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      brandId: map['brandId'] ?? '',
      category: map['category'] ?? '',
      categoryId: map['categoryId'] ?? '',
      description: map['description'] ?? '',
      sellerId: map['sellerId'] ?? '',
      sellerName: map['sellerName'] ?? '',
      status: map['status'] ?? 'inactive',
      createdAt: map['createdAt'] ?? '',
      variants: variantsList,
    );
  }
}