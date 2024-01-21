class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int? age;
  DateTime createdAt;
  DateTime updatedAt;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.age,
    required this.createdAt,
    required this.updatedAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "age": age,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
      };
}
