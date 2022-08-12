import 'package:cloud_firestore/cloud_firestore.dart';

class ShipmentModel {
  late String id;
  String? name;
  List<LocationModel>? route = [];
  DateTime? createdAt;
  DateTime? deliveredAt;

  // 'createdAt': DateTime.now(),
  // 'name': data.name,
  // 'shipment_id': shipmentId,
  ShipmentModel({
    required this.id,
    this.name,
    this.route,
    this.createdAt,
    this.deliveredAt,
  });

  ShipmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    route = (json['route'] as List<LocationModel>)
        .map((location) => LocationModel.fromJson(location.toJson())) as List<LocationModel>;
    createdAt = (json['createdAt']).toDate();
    deliveredAt = (json['deliveredAt']).toDate();
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'route': route?.map((location) => location.toJson()).toList(),
        'createdAt': createdAt,
        'deliveredAt': deliveredAt,
      };
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
    createdAt = DateTime.parse(json['createdAt'] as String);
  }
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': createdAt.toIso8601String(),
      };
}
