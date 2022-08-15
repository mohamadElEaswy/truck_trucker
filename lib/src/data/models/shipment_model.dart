class ShipmentModel {
  late String id;
  String? name;
  DateTime? createdAt;

  ShipmentModel({
    required this.id,
    this.name,
    this.createdAt,
  });

  ShipmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;

    createdAt = (json['createdAt']).toDate();
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }
}

class LocationModel {
  late double latitude;
  late double longitude;
  late DateTime createdAt;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] as double;
    longitude = json['longitude'] as double;
    createdAt = DateTime.parse(json['timestamp'] as String);
  }
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': createdAt.toIso8601String(),
      };
}
