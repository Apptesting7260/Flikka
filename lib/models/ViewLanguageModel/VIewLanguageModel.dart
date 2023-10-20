// To parse this JSON data, do
//
//     final viewLanguageModel = viewLanguageModelFromJson(jsonString);

import 'dart:convert';

ViewLanguageModel viewLanguageModelFromJson(String str) => ViewLanguageModel.fromJson(json.decode(str));

String viewLanguageModelToJson(ViewLanguageModel data) => json.encode(data.toJson());

class ViewLanguageModel {
  bool? status;
  List<LanguageModel>? languages;

  ViewLanguageModel({
    this.status,
    this.languages,
  });

  factory ViewLanguageModel.fromJson(Map<String, dynamic> json) => ViewLanguageModel(
    status: json["status"],
    languages: List<LanguageModel>.from(json["languages"].map((x) => LanguageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class LanguageModel {
  dynamic id;
  String? languages;
  DateTime? createdAt;
  DateTime? updatedAt;

  LanguageModel({
    this.id,
    this.languages,
    this.createdAt,
    this.updatedAt,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    id: json["id"],
    languages: json["languages"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "languages": languages,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
