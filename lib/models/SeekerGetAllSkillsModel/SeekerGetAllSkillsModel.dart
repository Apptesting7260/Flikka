
// To parse this JSON data, do
//
//     final seekerGetAllSkillsModel = seekerGetAllSkillsModelFromJson(jsonString);

import 'dart:convert';

SeekerGetAllSkillsModel seekerGetAllSkillsModelFromJson(String str) => SeekerGetAllSkillsModel.fromJson(json.decode(str));

String seekerGetAllSkillsModelToJson(SeekerGetAllSkillsModel data) => json.encode(data.toJson());

class SeekerGetAllSkillsModel {
  bool? status;
  List<Availabity>? softSkill;
  List<Availabity>? passion;
  List<Availabity>? industry;
  List<Availabity>? strengths;
  List<Availabity>? salaryExpectation;
  List<Availabity>? startWork;
  List<Availabity>? availabity;
  String? message;

  SeekerGetAllSkillsModel({
    this.status,
    this.softSkill,
    this.passion,
    this.industry,
    this.strengths,
    this.salaryExpectation,
    this.startWork,
    this.availabity,
    this.message,
  });

  factory SeekerGetAllSkillsModel.fromJson(Map<String, dynamic> json) => SeekerGetAllSkillsModel(
    status: json["status"],
    softSkill: List<Availabity>.from(json["soft_skill"].map((x) => Availabity.fromJson(x))),
    passion: List<Availabity>.from(json["passion"].map((x) => Availabity.fromJson(x))),
    industry: List<Availabity>.from(json["industry"].map((x) => Availabity.fromJson(x))),
    strengths: List<Availabity>.from(json["strengths"].map((x) => Availabity.fromJson(x))),
    salaryExpectation: List<Availabity>.from(json["salary_expectation"].map((x) => Availabity.fromJson(x))),
    startWork: List<Availabity>.from(json["start_work"].map((x) => Availabity.fromJson(x))),
    availabity: List<Availabity>.from(json["availabity"].map((x) => Availabity.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "soft_skill": List<dynamic>.from(softSkill!.map((x) => x.toJson())),
    "passion": List<dynamic>.from(passion!.map((x) => x.toJson())),
    "industry": List<dynamic>.from(industry!.map((x) => x.toJson())),
    "strengths": List<dynamic>.from(strengths!.map((x) => x.toJson())),
    "salary_expectation": List<dynamic>.from(salaryExpectation!.map((x) => x.toJson())),
    "start_work": List<dynamic>.from(startWork!.map((x) => x.toJson())),
    "availabity": List<dynamic>.from(availabity!.map((x) => x.toJson())),
    "message": message,
  };
}

class Availabity {
  var id;
  String? availabity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? industryPreferences;
  String? passion;
  String? salaryExpectation;
  String? skills;
  String? startWork;
  String? strengths;

  Availabity({
    this.id,
    this.availabity,
    this.createdAt,
    this.updatedAt,
    this.industryPreferences,
    this.passion,
    this.salaryExpectation,
    this.skills,
    this.startWork,
    this.strengths,
  });

  factory Availabity.fromJson(Map<String, dynamic> json) => Availabity(
    id: json["id"],
    availabity: json["availabity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    industryPreferences: json["industry_preferences"],
    passion: json["passion"],
    salaryExpectation: json["salary_expectation"],
    skills: json["skills"],
    startWork: json["start_work"],
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "availabity": availabity,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "industry_preferences": industryPreferences,
    "passion": passion,
    "salary_expectation": salaryExpectation,
    "skills": skills,
    "start_work": startWork,
    "strengths": strengths,
  };
}
