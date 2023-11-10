// To parse this JSON data, do
//
//     final recruiterHomeModel = recruiterHomeModelFromJson(jsonString);

import 'dart:convert';

import 'package:flikka/models/ViewLanguageModel/VIewLanguageModel.dart';

RecruiterHomeModel recruiterHomeModelFromJson(String str) => RecruiterHomeModel.fromJson(json.decode(str));

String recruiterHomeModelToJson(RecruiterHomeModel data) => json.encode(data.toJson());

class RecruiterHomeModel {
  bool? status;
  List<RecruiterHomeData>? data;

  RecruiterHomeModel({
    this.status,
    this.data,
  });

  factory RecruiterHomeModel.fromJson(Map<String, dynamic> json) => RecruiterHomeModel(
    status: json["status"],
    data: json["data"] == null ? json["data"] : List<RecruiterHomeData>.from(json["data"].map((x) => RecruiterHomeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RecruiterHomeData {
  dynamic id;
  String? profileImg;
  String? fullname;
  String? email;
  String? password;
  String? location;
  String? aboutMe;
  String? documentType;
  String? documentImg;
  String? resume;
  dynamic totalExperience;
  String? referralCode;
  String? referralBy;
  dynamic currentAmount;
  String? status;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  RecruiterHomeSeekerData? seekerData;

  RecruiterHomeData({
    this.id,
    this.profileImg,
    this.fullname,
    this.email,
    this.password,
    this.location,
    this.aboutMe,
    this.documentType,
    this.documentImg,
    this.resume,
    this.totalExperience,
    this.referralCode,
    this.referralBy,
    this.currentAmount,
    this.status,
    this.googleId,
    this.createdAt,
    this.updatedAt,
    this.seekerData,
  });

  factory RecruiterHomeData.fromJson(Map<String, dynamic> json) => RecruiterHomeData(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    location: json["location"],
    aboutMe: json["about_me"],
    documentType: json["document_type"],
    documentImg: json["document_img"],
    resume: json["resume"],
    totalExperience: json["total_experience"],
    referralCode: json["referral_code"],
    referralBy: json["referral_by"],
    currentAmount: json["current_amount"],
    status: json["status"],
    googleId: json["google_id"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    seekerData: json["seeker_data"] == null ? json["seeker_data"] : RecruiterHomeSeekerData.fromJson(json["seeker_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
    "email": email,
    "password": password,
    "location": location,
    "about_me": aboutMe,
    "document_type": documentType,
    "document_img": documentImg,
    "resume": resume,
    "total_experience": totalExperience,
    "referral_code": referralCode,
    "referral_by": referralBy,
    "current_amount": currentAmount,
    "status": status,
    "google_id": googleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "seeker_data": seekerData?.toJson(),
  };
}

class RecruiterHomeSeekerData {
  dynamic id;
  dynamic seekerId;
  String? position;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  dynamic fresher;
  List<WorkExpJob>? workExpJob;
  List<EducationLevel>? educationLevel;
  dynamic language;
  List<Appreciation>? appreciation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? positions;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  List<LanguageModel>? languageName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;

  RecruiterHomeSeekerData({
    this.id,
    this.seekerId,
    this.position,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.fresher,
    this.workExpJob,
    this.educationLevel,
    this.language,
    this.appreciation,
    this.createdAt,
    this.updatedAt,
    this.positions,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.languageName,
    this.startWorkName,
    this.availabityName,
  });

  factory RecruiterHomeSeekerData.fromJson(Map<String, dynamic> json) => RecruiterHomeSeekerData(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    minSalaryExpectation: json["min_salary_expectation"],
    maxSalaryExpectation: json["max_salary_expectation"],
    fresher: json["fresher"],
    workExpJob: json["work_exp_job"] == null ? json["work_exp_job"] : List<WorkExpJob>.from(json["work_exp_job"].map((x) => WorkExpJob.fromJson(x))),
    educationLevel: json["education_level"] == null ? json["education_level"] : List<EducationLevel>.from(json["education_level"].map((x) => EducationLevel.fromJson(x))),
    language: json["language"],
    appreciation: json["appreciation"] == null ? json["appreciation"] : List<Appreciation>.from(json["appreciation"].map((x) => Appreciation.fromJson(x))),
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    positions: json["positions"],
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageModel>.from(json["language_name"].map((x) => LanguageModel.fromJson(x))),
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "position": position,
    "min_salary_expectation": minSalaryExpectation,
    "max_salary_expectation": maxSalaryExpectation,
    "fresher": fresher,
    "work_exp_job": List<dynamic>.from(workExpJob!.map((x) => x.toJson())),
    "education_level": List<dynamic>.from(educationLevel!.map((x) => x.toJson())),
    "language": language,
    "appreciation": List<dynamic>.from(appreciation!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "positions": positions,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "language_name": List<dynamic>.from(languageName!.map((x) => x.toJson())),
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class Appreciation {
  String? awardName;
  String? achievement;

  Appreciation({
    this.awardName,
    this.achievement,
  });

  factory Appreciation.fromJson(Map<String, dynamic> json) => Appreciation(
    awardName: json["award_name"],
    achievement: json["achievement"],
  );

  Map<String, dynamic> toJson() => {
    "award_name": awardName,
    "achievement": achievement,
  };
}

class AvailabityName {
  dynamic id;
  String? availabity;

  AvailabityName({
    this.id,
    this.availabity,
  });

  factory AvailabityName.fromJson(Map<String, dynamic> json) => AvailabityName(
    id: json["id"],
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "availabity": availabity,
  };
}


class EducationLevel {
  String? educationLevel;
  String? institutionName;
  DateTime? educationStartDate;
  dynamic educationEndDate;
  dynamic fieldOfStudy;

  EducationLevel({
    this.educationLevel,
    this.institutionName,
    this.educationStartDate,
    this.educationEndDate,
    this.fieldOfStudy,
  });

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
    educationLevel: json["education_level"],
    institutionName: json["institution_name"],
    educationStartDate: json["education_start_date"] == null ? json["education_start_date"] : DateTime.parse(json["education_start_date"]),
    educationEndDate: json["education_end_date"],
    fieldOfStudy: json["field_of_study"],
  );

  Map<String, dynamic> toJson() => {
    "education_level": educationLevel,
    "institution_name": institutionName,
    "education_start_date": "${educationStartDate?.year.toString().padLeft(4, '0')}-${educationStartDate?.month.toString().padLeft(2, '0')}-${educationStartDate?.day.toString().padLeft(2, '0')}",
    "education_end_date": educationEndDate,
    "field_of_study": fieldOfStudy,
  };
}

class IndustryPreferenceName {
  dynamic id;
  dynamic industryPreferences;

  IndustryPreferenceName({
    this.id,
    this.industryPreferences,
  });

  factory IndustryPreferenceName.fromJson(Map<String, dynamic> json) => IndustryPreferenceName(
    id: json["id"],
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "industry_preferences": industryPreferences,
  };
}

class PassionName {
  dynamic id;
  dynamic passion;

  PassionName({
    this.id,
    this.passion,
  });

  factory PassionName.fromJson(Map<String, dynamic> json) => PassionName(
    id: json["id"],
    passion: json["passion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "passion": passion,
  };
}

class SkillName {
  dynamic id;
  String? skills;

  SkillName({
    this.id,
    this.skills,
  });

  factory SkillName.fromJson(Map<String, dynamic> json) => SkillName(
    id: json["id"],
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "skills": skills,
  };
}

class StartWorkName {
  dynamic id;
  dynamic startWork;

  StartWorkName({
    this.id,
    this.startWork,
  });

  factory StartWorkName.fromJson(Map<String, dynamic> json) => StartWorkName(
    id: json["id"],
    startWork: json["start_work"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_work": startWork,
  };
}


class StrengthsName {
  dynamic id;
  dynamic strengths;

  StrengthsName({
    this.id,
    this.strengths,
  });

  factory StrengthsName.fromJson(Map<String, dynamic> json) => StrengthsName(
    id: json["id"],
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "strengths": strengths,
  };
}


class WorkExpJob {
  String? workExpJob;
  String? companyName;
  DateTime? jobStartDate;
  dynamic jobEndDate;

  WorkExpJob({
    this.workExpJob,
    this.companyName,
    this.jobStartDate,
    this.jobEndDate,
  });

  factory WorkExpJob.fromJson(Map<String, dynamic> json) => WorkExpJob(
    workExpJob: json["work_exp_job"],
    companyName: json["company_name"],
    jobStartDate: json["job_start_date"] == null ? json["job_start_date"] : DateTime.parse(json["job_start_date"]),
    jobEndDate: json["job_end_date"],
  );

  Map<String, dynamic> toJson() => {
    "work_exp_job": workExpJob,
    "company_name": companyName,
    "job_start_date": "${jobStartDate?.year.toString().padLeft(4, '0')}-${jobStartDate?.month.toString().padLeft(2, '0')}-${jobStartDate?.day.toString().padLeft(2, '0')}",
    "job_end_date": jobEndDate,
  };
}
