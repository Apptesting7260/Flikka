// To parse this JSON data, do
//
//     final applicantTrackingDataModel = applicantTrackingDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:flikka/models/ViewLanguageModel/VIewLanguageModel.dart';
import 'package:get/get.dart';

ApplicantTrackingDataModel applicantTrackingDataModelFromJson(String str) => ApplicantTrackingDataModel.fromJson(json.decode(str));

String applicantTrackingDataModelToJson(ApplicantTrackingDataModel data) => json.encode(data.toJson());

class ApplicantTrackingDataModel {
  bool? status;
  List<CandidateStatusElement>? candidateStatus;

  ApplicantTrackingDataModel({
    this.status,
    this.candidateStatus,
  });

  factory ApplicantTrackingDataModel.fromJson(Map<String, dynamic> json) => ApplicantTrackingDataModel(
    status: json["status"],
    candidateStatus: json["candidate_status"] == null ? json["candidate_status"] : List<CandidateStatusElement>.from(json["candidate_status"].map((x) => CandidateStatusElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "candidate_status": List<dynamic>.from(candidateStatus!.map((x) => x.toJson())),
  };
}

class CandidateStatusElement {
  dynamic id;
  String? jobTitle;
  String? jobPositions;
  List<LanguageModel>? languageName;
  List<TrackingAppliedJob>? appliedJob;

  CandidateStatusElement({
    this.id,
    this.jobTitle,
    this.jobPositions,
    this.languageName,
    this.appliedJob,
  });

  factory CandidateStatusElement.fromJson(Map<String, dynamic> json) => CandidateStatusElement(
    id: json["id"],
    jobTitle: json["job_title"],
    jobPositions: json["job_positions"],
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageModel>.from(json["language_name"].map((x) => x)),
    appliedJob: json["applied_job"] == null ? json["applied_job"] : List<TrackingAppliedJob>.from(json["applied_job"].map((x) => TrackingAppliedJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_title": jobTitle,
    "job_positions": jobPositions,
    "language_name": List<dynamic>.from(languageName!.map((x) => x)),
    "applied_job": List<dynamic>.from(appliedJob!.map((x) => x.toJson())),
  };
}

class TrackingAppliedJob {
  dynamic id;
  dynamic seekerId;
  dynamic jobId;
  String? candidateStatus;
  String? interviews;
  DateTime? createdAt;
  DateTime? updatedAt;
  SeekerData? seekerData;

  TrackingAppliedJob({
    this.id,
    this.seekerId,
    this.jobId,
    this.candidateStatus,
    this.interviews,
    this.createdAt,
    this.updatedAt,
    this.seekerData,
  });

  factory TrackingAppliedJob.fromJson(Map<String, dynamic> json) => TrackingAppliedJob(
    id: json["id"],
    seekerId: json["seeker_id"],
    jobId: json["job_id"],
    candidateStatus: json["candidate_status"],
    interviews: json["interviews"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    seekerData: json["seeker_data"] == null ? json["seeker_data"] : SeekerData.fromJson(json["seeker_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "job_id": jobId,
    "candidate_status": candidateStatus,
    "interviews": interviews,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "seeker_data": seekerData?.toJson(),
  };
}

class SeekerData {
  dynamic id;
  String? profileImg;
  String? fullname;
  String? location;

  SeekerData({
    this.id,
    this.profileImg,
    this.fullname,
    this.location,
  });

  factory SeekerData.fromJson(Map<String, dynamic> json) => SeekerData(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
    "location": location,
  };
}