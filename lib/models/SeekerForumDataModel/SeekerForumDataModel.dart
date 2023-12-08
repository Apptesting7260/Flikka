// To parse this JSON data, do
//
//     final seekerForumDataModel = seekerForumDataModelFromJson(jsonString);

import 'dart:convert';

SeekerForumDataModel seekerForumDataModelFromJson(String str) => SeekerForumDataModel.fromJson(json.decode(str));

String seekerForumDataModelToJson(SeekerForumDataModel data) => json.encode(data.toJson());

class SeekerForumDataModel {
  bool? status;
  List<ForumDatum>? forumData;

  SeekerForumDataModel({
    this.status,
    this.forumData,
  });

  factory SeekerForumDataModel.fromJson(Map<String, dynamic> json) => SeekerForumDataModel(
    status: json["status"],
    forumData: json["forum_data"] == null ? json["forum_data"] : List<ForumDatum>.from(json["forum_data"].map((x) => ForumDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "forum_data": List<dynamic>.from(forumData!.map((x) => x.toJson())),
  };
}

class ForumDatum {
  dynamic id;
  dynamic seekerId;
  dynamic industryId;
  String? title;
  String? titleDescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  ForumDatum({
    this.id,
    this.seekerId,
    this.industryId,
    this.title,
    this.titleDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory ForumDatum.fromJson(Map<String, dynamic> json) => ForumDatum(
    id: json["id"],
    seekerId: json["seeker_id"],
    industryId: json["industry_id"],
    title: json["title"],
    titleDescription: json["title_description"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "industry_id": industryId,
    "title": title,
    "title_description": titleDescription,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
