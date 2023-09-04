class ShipModel {
  ShipModel({
    required this.id,
    required this.model,
    required this.name,
    required this.image,
    required this.status,
    required this.yearBuilt,
    required this.type,
  });

  factory ShipModel.fromJson(Map<String, dynamic> json) => ShipModel(
    id: json['id'] as String? ?? '',
    model: json['model'] as String? ?? '',
    name: json['name'] as String? ?? '',
    image: json['image'] as String? ?? '',
    status: json['status'] as String? ?? '',
    yearBuilt: json['year_built'] as int? ?? 0,
    type: json['type'] as String? ?? '',
  );

  final String id;
  final String model;
  final String name;
  final String image;
  final String status;
  final int yearBuilt;
  final String type;
}