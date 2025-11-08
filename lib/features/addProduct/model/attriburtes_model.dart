class AttriburtesModel {
  final String id;
  final String name;
  final String dataType;
  final List<String> options;
  final int sortOrder;

  AttriburtesModel({
    required this.id,
    required this.name,
    required this.dataType,
    required this.options,
    required this.sortOrder,
  });

  factory AttriburtesModel.fromMap(Map<String, dynamic> data, String id) {
    return AttriburtesModel(
      id: id,
      name: data['name'] ?? '',
      dataType: data['dataType'] ?? '',
      options: List<String>.from(data['options'] ?? []),
      sortOrder: data['sortOrder'] ?? 0,
    );
  }
}
