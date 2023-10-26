// To parse this JSON data, do
//
//     final seekerSavedPostModel = seekerSavedPostModelFromJson(jsonString);

import 'dart:convert';

SeekerSavedJobsListModel seekerSavedPostModelFromJson(String str) => SeekerSavedJobsListModel.fromJson(json.decode(str));

String seekerSavedPostModelToJson(SeekerSavedJobsListModel data) => json.encode(data.toJson());

class SeekerSavedJobsListModel {
  bool? status;
  List<SeekerSavedPostDatum>? data;

  SeekerSavedJobsListModel({
    this.status,
    this.data,
  });

  factory SeekerSavedJobsListModel.fromJson(Map<String, dynamic> json) => SeekerSavedJobsListModel(
    status: json["status"],
    data: json["data"] == null ? json["data"] : List<SeekerSavedPostDatum>.from(json["data"].map((x) => SeekerSavedPostDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SeekerSavedPostDatum {
  dynamic id;
  dynamic seekerId;
  dynamic jobId;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  SeekerSavedJobData? jobData;

  SeekerSavedPostDatum({
    this.id,
    this.seekerId,
    this.jobId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.jobData,
  });

  factory SeekerSavedPostDatum.fromJson(Map<String, dynamic> json) => SeekerSavedPostDatum(
    id: json["id"],
    seekerId: json["seeker_id"],
    jobId: json["job_id"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    jobData: json["job_data"] == null ? json["job_data"] : SeekerSavedJobData.fromJson(json["job_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "job_id": jobId,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_data": jobData?.toJson(),
  };
}

class SeekerSavedJobData {
  dynamic id;
  dynamic recruiterId;
  String? featureImg;
  String? jobTitle;
  String? jobPosition;
  String? specialization;
  String? jobLocation;
  String? description;
  String? requirements;
  String? employmentType;
  String? typeOfWorkplace;
  String? workExperience;
  String? preferredWorkExperience;
  String? education;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? jobPositions;
  SeekerSavedJobsDetail? jobsDetail;

  SeekerSavedJobData({
    this.id,
    this.recruiterId,
    this.featureImg,
    this.jobTitle,
    this.jobPosition,
    this.specialization,
    this.jobLocation,
    this.description,
    this.requirements,
    this.employmentType,
    this.typeOfWorkplace,
    this.workExperience,
    this.preferredWorkExperience,
    this.education,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.jobPositions,
    this.jobsDetail,
  });

  factory SeekerSavedJobData.fromJson(Map<String, dynamic> json) => SeekerSavedJobData(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    featureImg: json["feature_img"],
    jobTitle: json["job_title"],
    jobPosition: json["job_position"],
    specialization: json["specialization"],
    jobLocation: json["job_location"],
    description: json["description"],
    requirements: json["requirements"],
    employmentType: json["employment_type"],
    typeOfWorkplace: json["type_of_workplace"],
    workExperience: json["work_experience"],
    preferredWorkExperience: json["preferred_work_experience"],
    education: json["education"],
    language: json["language"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    jobPositions: json["job_positions"],
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : SeekerSavedJobsDetail.fromJson(json["jobs_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "feature_img": featureImg,
    "job_title": jobTitle,
    "job_position": jobPosition,
    "specialization": specialization,
    "job_location": jobLocation,
    "description": description,
    "requirements": requirements,
    "employment_type": employmentType,
    "type_of_workplace": typeOfWorkplace,
    "work_experience": workExperience,
    "preferred_work_experience": preferredWorkExperience,
    "education": education,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_positions": jobPositions,
    "jobs_detail": jobsDetail?.toJson(),
  };
}

class SeekerSavedJobsDetail {
  dynamic id;
  dynamic jobId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SeekerSavedPostSkillName>? skillName;
  List<SeekerSavedPostPassionName>? passionName;
  List<SeekerSavedPostIndustryPreferenceName>? industryPreferenceName;
  List<SeekerSavedPostStrengthsName>? strengthsName;
  String? salaryExpectationName;
  List<SeekerSavedPostStartWorkName>? startWorkName;
  List<SeekerSavedPostAvailabityName>? availabityName;

  SeekerSavedJobsDetail({
    this.id,
    this.jobId,
    this.createdAt,
    this.updatedAt,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
  });

  factory SeekerSavedJobsDetail.fromJson(Map<String, dynamic> json) => SeekerSavedJobsDetail(
    id: json["id"],
    jobId: json["job_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SeekerSavedPostSkillName>.from(json["skill_name"].map((x) => SeekerSavedPostSkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<SeekerSavedPostPassionName>.from(json["passion_name"].map((x) => SeekerSavedPostPassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<SeekerSavedPostIndustryPreferenceName>.from(json["industry_preference_name"].map((x) => SeekerSavedPostIndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<SeekerSavedPostStrengthsName>.from(json["strengths_name"].map((x) => SeekerSavedPostStrengthsName.fromJson(x))),
    salaryExpectationName: json["salary_expectation_name"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<SeekerSavedPostStartWorkName>.from(json["start_work_name"].map((x) => SeekerSavedPostStartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<SeekerSavedPostAvailabityName>.from(json["availabity_name"].map((x) => SeekerSavedPostAvailabityName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "salary_expectation_name": salaryExpectationName,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class SeekerSavedPostAvailabityName {
  String? availabity;

  SeekerSavedPostAvailabityName({
    this.availabity,
  });

  factory SeekerSavedPostAvailabityName.fromJson(Map<String, dynamic> json) => SeekerSavedPostAvailabityName(
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "availabity": availabity,
  };
}

class SeekerSavedPostIndustryPreferenceName {
  String? industryPreferences;

  SeekerSavedPostIndustryPreferenceName({
    this.industryPreferences,
  });

  factory SeekerSavedPostIndustryPreferenceName.fromJson(Map<String, dynamic> json) => SeekerSavedPostIndustryPreferenceName(
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "industry_preferences": industryPreferences,
  };
}

class SeekerSavedPostPassionName {
  String? passion;

  SeekerSavedPostPassionName({
    this.passion,
  });

  factory SeekerSavedPostPassionName.fromJson(Map<String, dynamic> json) => SeekerSavedPostPassionName(
    passion: json["passion"],
  );

  Map<String, dynamic> toJson() => {
    "passion": passion,
  };
}

class SeekerSavedPostSkillName {
  String? skills;

  SeekerSavedPostSkillName({
    this.skills,
  });

  factory SeekerSavedPostSkillName.fromJson(Map<String, dynamic> json) => SeekerSavedPostSkillName(
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "skills": skills,
  };
}

class SeekerSavedPostStartWorkName {
  String? startWork;

  SeekerSavedPostStartWorkName({
    this.startWork,
  });

  factory SeekerSavedPostStartWorkName.fromJson(Map<String, dynamic> json) => SeekerSavedPostStartWorkName(
    startWork: json["start_work"],
  );

  Map<String, dynamic> toJson() => {
    "start_work": startWork,
  };
}

class SeekerSavedPostStrengthsName {
  String? strengths;

  SeekerSavedPostStrengthsName({
    this.strengths,
  });

  factory SeekerSavedPostStrengthsName.fromJson(Map<String, dynamic> json) => SeekerSavedPostStrengthsName(
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "strengths": strengths,
  };
}
