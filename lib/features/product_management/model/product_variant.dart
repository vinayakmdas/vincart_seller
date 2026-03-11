class ProductVariant {
  final String color;
  final List<String> images;
  final double price;
  final double regularPrice;
  final int quantity;
  final Map<String, dynamic> selectedOptions;

  const ProductVariant({
    required this.color,
    required this.images,
    required this.price,
    required this.regularPrice,
    required this.quantity,
    required this.selectedOptions,
  });

  factory ProductVariant.fromMap(Map<String, dynamic> map) {
    final variantImages = (map['images'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    final opts = Map<String, dynamic>.from(map['selectedOptions'] ?? {});
    return ProductVariant(
      color: map['colro'] ?? map['color'] ?? '',  // note: field is 'colro' in Firebase
      images: variantImages,
      price: (map['price'] ?? 0).toDouble(),
      regularPrice: (map['regularPrise'] ?? 0).toDouble(), // note: 'regularPrise' in Firebase
      quantity: (map['quantity'] ?? 0).toInt(),
      selectedOptions: opts,
    );
  }
}
