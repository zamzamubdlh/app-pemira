class VoteModel {
  int id;
  String year;
  int candidateId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String? candidateName;

  VoteModel({
    required this.id,
    required this.year,
    required this.candidateId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.candidateName,
  });

  factory VoteModel.fromJson(Map<String, dynamic> json) => VoteModel(
        id: json["id"],
        year: json["year"],
        candidateId: json["candidate_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
        candidateName: json["candidate_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "candidate_id": candidateId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "candidate_name": candidateName,
      };
}
