class ShipmentModel {
  late String id;
  String? name;
  List<Location>? route = [];
  // Location? location;

  ShipmentModel({
    required this.id,
    this.name,
    this.route,
    // this.location,
  });

  ShipmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    route = (json['route'] as List)
        .map((location) => Location.fromJson(location)) as List<Location>;
    // location = Location.fromJson(json['location']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'route': route!.map((location) => location.toJson()).toList(),
        // 'location': location,
      };
}

class Location {
  late double latitude;
  late double longitude;
  late DateTime timestamp;

  Location({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] as double;
    longitude = json['longitude'] as double;
    timestamp = DateTime.parse(json['timestamp'] as String);
  }
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp.toIso8601String(),
      };
}
