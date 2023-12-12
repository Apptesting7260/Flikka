
import 'dart:convert';
import '../ViewLanguageModel/VIewLanguageModel.dart';
import '../ViewSeekerProfileModel/ViewSeekerProfileModel.dart';

RecruiterHomePageModel recruiterHomePageModelFromJson(String str) => RecruiterHomePageModel.fromJson(json.decode(str));

String recruiterHomePageModelToJson(RecruiterHomePageModel data) => json.encode(data.toJson());

class RecruiterHomePageModel {
  bool? status;
  String? message;
  List<RecruiterHomePageSeekerDetail>? Seeker_Details;

  RecruiterHomePageModel({
    this.status,
    this.message,
    this.Seeker_Details,
  });

  factory RecruiterHomePageModel.fromJson(Map<String, dynamic> json) => RecruiterHomePageModel(
    status: json["status"],
    message: json["message"],
    Seeker_Details: json["Seeker_Details"] == null ? json["Seeker_Details"] : List<RecruiterHomePageSeekerDetail>.from(json["Seeker_Details"].map((x) => RecruiterHomePageSeekerDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Seeker_Details": List<dynamic>.from(Seeker_Details!.map((x) => x.toJson())),
  };
}

class RecruiterHomePageSeekerDetail {
  dynamic id;
  dynamic seekerId;
  dynamic position;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  dynamic fresher;
  dynamic video ;
  List<WorkExpJob>? workExpJob;
  List<EducationLevel>? educationLevel;
  List<LanguageModel>? language;
  List<Appreciation>? appreciation;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic jobMatchPercentage;
  String? positions;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  dynamic salaryExpectationName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;
  RecruiterHomePageSeeker? seeker;

  RecruiterHomePageSeekerDetail({
    this.id,
    this.seekerId,
    this.position,
    this.video,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.fresher,
    this.workExpJob,
    this.educationLevel,
    this.language,
    this.appreciation,
    this.createdAt,
    this.updatedAt,
    this.jobMatchPercentage,
    this.positions,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
    this.seeker,
  });

  factory RecruiterHomePageSeekerDetail.fromJson(Map<String, dynamic> json) => RecruiterHomePageSeekerDetail(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    video: json["short_video"],
    minSalaryExpectation: json["min_salary_expectation"],
    maxSalaryExpectation: json["max_salary_expectation"],
    fresher: json["fresher"],
    workExpJob: json["work_exp_job"] == null ? json["work_exp_job"] : List<WorkExpJob>.from(json["work_exp_job"].map((x) => WorkExpJob.fromJson(x))),
    educationLevel: json["education_level"] == null ? json["education_level"] : List<EducationLevel>.from(json["education_level"].map((x) => EducationLevel.fromJson(x))),
    language: json["language"] == null ? json["language"] : List<LanguageModel>.from(json["language"].map((x) => LanguageModel.fromJson(x))),
    appreciation: json["appreciation"] == null ? json["appreciation"] : List<Appreciation>.from(json["appreciation"].map((x) => Appreciation.fromJson(x))),
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobMatchPercentage: json["job_match_percentage"],
    positions: json["positions"],
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    salaryExpectationName: json["salary_expectation_name"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
    seeker: json["seeker"] == null ? json["seeker"] : RecruiterHomePageSeeker.fromJson(json["seeker"]),
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
    "language": List<dynamic>.from(language!.map((x) => x.toJson())),
    "appreciation": List<dynamic>.from(appreciation!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_match_percentage": jobMatchPercentage,
    "positions": positions,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "salary_expectation_name": salaryExpectationName,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
    "seeker": seeker?.toJson(),
  };
}

class RecruiterHomePageSeeker {
  dynamic id;
  String? profileImg;
  String? video;
  String? fullname;
  String? email;
  String? password;
  String? mobile;
  String? location;
  String? aboutMe;
  String? documentType;
  String? documentImg;
  String? resume;
  String? referralCode;
  String? referralBy;
  String? currentAmount;
  dynamic resetPassOtp;
  dynamic resetPassOtpTime;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  RecruiterHomePageSeeker({
    this.id,
    this.profileImg,
    this.video,
    this.fullname,
    this.email,
    this.password,
    this.mobile,
    this.location,
    this.aboutMe,
    this.documentType,
    this.documentImg,
    this.resume,
    this.referralCode,
    this.referralBy,
    this.currentAmount,
    this.resetPassOtp,
    this.resetPassOtpTime,
    this.googleId,
    this.createdAt,
    this.updatedAt,
  });

  factory RecruiterHomePageSeeker.fromJson(Map<String, dynamic> json) => RecruiterHomePageSeeker(
    id: json["id"],
    profileImg: json["profile_img"],
    video: json["short_video"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    location: json["location"],
    aboutMe: json["about_me"],
    documentType: json["document_type"],
    documentImg: json["document_img"],
    resume: json["resume"],
    referralCode: json["referral_code"],
    referralBy: json["referral_by"],
    currentAmount: json["current_amount"],
    resetPassOtp: json["reset_pass_otp"],
    resetPassOtpTime: json["reset_pass_otp_time"],
    googleId: json["google_id"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "short_video": video,
    "fullname": fullname,
    "email": email,
    "password": password,
    "mobile": mobile,
    "location": location,
    "about_me": aboutMe,
    "document_type": documentType,
    "document_img": documentImg,
    "resume": resume,
    "referral_code": referralCode,
    "referral_by": referralBy,
    "current_amount": currentAmount,
    "reset_pass_otp": resetPassOtp,
    "reset_pass_otp_time": resetPassOtpTime,
    "google_id": googleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}




