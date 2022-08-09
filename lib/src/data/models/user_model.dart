class UserModel {
  late String name;
  late String phone;
  late String id;

  UserModel({
    required this.name,
    required this.phone,
    required this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    phone = json['phone'] as String;
    id = json['id'] as String;
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
      };
}
