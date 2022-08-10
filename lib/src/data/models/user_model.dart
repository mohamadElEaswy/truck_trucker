class UserModel {
  late String name;
  late String phone;
  late String id;
  late DateTime createdAt;

  UserModel({
    required this.name,
    required this.phone,
    required this.id,
    required this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    phone = json['phone'] as String;
    id = json['id'] as String;
    createdAt = DateTime.parse(json['createdAt'] as String);
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'createdAt': createdAt.toIso8601String(),
      };
}
