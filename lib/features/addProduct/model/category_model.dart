class CategoryModel {
    final String id;
  final String name;
  final String description;
  final String status;
  final List<String> requiredAttributes;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.requiredAttributes,
  });

 factory CategoryModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      name: data['category'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? '',
      requiredAttributes:
          List<String>.from(data['requiredAttributeIds'] ?? []),
    );
  }
}
