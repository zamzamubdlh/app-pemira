class ElectionFraud {
  int id;
  int userId;
  String date;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  ElectionFraud({
    required this.id,
    required this.userId,
    required this.date,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElectionFraud.fromJson(Map<String, dynamic> json) => ElectionFraud(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "edate": date,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
