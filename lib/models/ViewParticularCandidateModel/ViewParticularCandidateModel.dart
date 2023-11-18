// To parse this JSON data, do
//
//     final viewParticularCandidateModel = viewParticularCandidateModelFromJson(jsonString);

import 'dart:convert';

import 'package:flikka/models/RecruiterHomeModel/RecruiterHomeModel.dart';

ViewParticularCandidateModel viewParticularCandidateModelFromJson(String str) => ViewParticularCandidateModel.fromJson(json.decode(str));

String viewParticularCandidateModelToJson(ViewParticularCandidateModel data) => json.encode(data.toJson());

class ViewParticularCandidateModel {
  bool? status;
  RecruiterHomeData? seekerDetails;

  ViewParticularCandidateModel({
    this.status,
    this.seekerDetails,
  });

  factory ViewParticularCandidateModel.fromJson(Map<String, dynamic> json) => ViewParticularCandidateModel(
    status: json["status"],
    seekerDetails: json["seeker_details"] == null ? json["seeker_details"] : RecruiterHomeData.fromJson(json["seeker_details"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "seeker_details": seekerDetails?.toJson(),
  };
}
