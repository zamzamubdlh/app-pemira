class CandidateModel {
  int id;
  int userId;
  int age;
  String programStudy;
  String shortDescription;
  String vision;
  String mission;
  String photo;
  String reasonForChoice;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String? token;
  String? year;
  String? candidateName;

  CandidateModel({
    required this.id,
    required this.userId,
    required this.age,
    required this.programStudy,
    required this.shortDescription,
    required this.vision,
    required this.mission,
    required this.photo,
    required this.reasonForChoice,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.token,
    this.year,
    this.candidateName,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        id: json["id"],
        userId: json["user_id"],
        age: json["age"],
        programStudy: json["program_study"],
        shortDescription: json["short_description"],
        vision: json["vision"],
        mission: json["mission"],
        photo: json["photo"],
        reasonForChoice: json["reason_for_choice"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
        name: json["name"],
        token: json["token"],
        year: json["year"],
        candidateName: json["candidate_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "program_study": programStudy,
        "short_description": shortDescription,
        "vision": vision,
        "mission": mission,
        "photo": photo,
        "reason_for_choice": reasonForChoice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "token": token,
        "year": year,
        "candidate_name": candidateName,
      };
}
