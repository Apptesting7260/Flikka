

import 'dart:convert';

ViewSeekerProfileModel viewSeekerProfileModelFromJson(String str) => ViewSeekerProfileModel.fromJson(json.decode(str));

String viewSeekerProfileModelToJson(ViewSeekerProfileModel data) => json.encode(data.toJson());

class ViewSeekerProfileModel {
  bool? status;
  var completeProfile;
  SeekerInfo? seekerInfo;
  SeekerDetails? seekerDetails;
  var message;

  ViewSeekerProfileModel({
    this.status,
    this.completeProfile,
    this.seekerInfo,
    this.seekerDetails,
    this.message,
  });

  factory ViewSeekerProfileModel.fromJson(Map<String, dynamic> json) => ViewSeekerProfileModel(
    status: json["status"],
    completeProfile: json["Complite-Profile"],
    seekerInfo: SeekerInfo.fromJson(json["Seeker_info"]),
    seekerDetails: SeekerDetails.fromJson(json["seeker_dtls"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "Complite-Profile": completeProfile,
    "Seeker_info": seekerInfo?.toJson(),
    "seeker_dtls": seekerDetails?.toJson(),
    "message": message,
  };
}

class SeekerDetails {
  var id;
  var seekerId;
  dynamic position ;
  List<WorkExpJob>? workExpJob;
  List<EducationLevel>? educationLevel;
  List<String>? language;
  List<Appreciation>? appreciation;
  DateTime? createdAt;
  DateTime? updatedAt;
  var positions;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  var salaryExpectationName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;

  SeekerDetails({
    this.id,
    this.seekerId,
    this.position ,
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
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
  });

  factory SeekerDetails.fromJson(Map<String, dynamic> json) => SeekerDetails(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    workExpJob: json["work_exp_job"] == null ? json["work_exp_job"] : List<WorkExpJob>.from(json["work_exp_job"].map((x) => WorkExpJob.fromJson(x))),
    educationLevel: json["education_level"] == null ? json["education_level"] : List<EducationLevel>.from(json["education_level"].map((x) => EducationLevel.fromJson(x))),
    language:  json["language_name"] == null ? json["language_name"] : List<String>.from(json["language_name"].map((x) => x)),
    appreciation: json["appreciation"] == null ? json["appreciation"] : List<Appreciation>.from(json["appreciation"].map((x) => Appreciation.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    positions: json["positions"],
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    salaryExpectationName: json["salary_expectation_name"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "position" : position ,
    "work_exp_job": List<dynamic>.from(workExpJob!.map((x) => x.toJson())),
    "education_level": List<dynamic>.from(educationLevel!.map((x) => x.toJson())),
    "language_name": List<dynamic>.from(language!.map((x) => x)),
    "appreciation": List<dynamic>.from(appreciation!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "positions": positions,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "salary_expectation_name": salaryExpectationName,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class Appreciation {
  var awardName;
  var achievement;
  // DateTime? awardEndDate;

  Appreciation({
    this.awardName,
    this.achievement,
    // this.awardEndDate,
  });

  factory Appreciation.fromJson(Map<String, dynamic> json) => Appreciation(
    awardName: json["award_name"],
    achievement: json["achievement"],
    // awardEndDate: DateTime.parse(json["award_end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "award_name": awardName,
    "achievement": achievement,
    // "award_end_date": "${awardEndDate?.year.toString().padLeft(4, '0')}-${awardEndDate?.month.toString().padLeft(2, '0')}-${awardEndDate?.day.toString().padLeft(2, '0')}",
  };
}

class AvailabityName {
  var availabity;

  AvailabityName({
    this.availabity,
  });

  factory AvailabityName.fromJson(Map<String, dynamic> json) => AvailabityName(
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "availabity": availabity,
  };
}

class EducationLevel {
  var educationLevel;
  var institutionName;
  var fieldOfStudy;
  String? educationStartDate;
  String? educationEndDate;

  EducationLevel({
    this.educationLevel,
    this.institutionName,
    this.fieldOfStudy,
    this.educationStartDate,
    this.educationEndDate,
  });

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
    educationLevel: json["education_level"],
    institutionName: json["institution_name"],
    fieldOfStudy: json["field_of_study"],
    educationStartDate: json["education_start_date"] ,
        // == null ? json["education_start_date"] : DateTime.parse(json["education_start_date"]),
    educationEndDate: json["education_end_date"]
        // == null ? json["education_end_date"] : DateTime.parse(json["education_end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "education_level": educationLevel,
    "institution_name": institutionName,
    "field_of_study": fieldOfStudy,
    "education_start_date": "$educationStartDate" ,
        // ?.year.toString().padLeft(4, '0')}-${educationStartDate?.month.toString().padLeft(2, '0')}-${educationStartDate?.day.toString().padLeft(2, '0')}",
    "education_end_date": "$educationEndDate" ,
      // .year.toString().padLeft(4, '0')}-${educationEndDate?.month.toString().padLeft(2, '0')}-${educationEndDate?.day.toString().padLeft(2, '0')}",
  };
}

class IndustryPreferenceName {
  var industryPreferences;

  IndustryPreferenceName({
    this.industryPreferences,
  });

  factory IndustryPreferenceName.fromJson(Map<String, dynamic> json) => IndustryPreferenceName(
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "industry_preferences": industryPreferences,
  };
}

class PassionName {
  var passion;

  PassionName({
    this.passion,
  });

  factory PassionName.fromJson(Map<String, dynamic> json) => PassionName(
    passion: json["passion"],
  );

  Map<String, dynamic> toJson() => {
    "passion": passion,
  };
}

class SkillName {
  var skills;

  SkillName({
    this.skills,
  });

  factory SkillName.fromJson(Map<String, dynamic> json) => SkillName(
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "skills": skills,
  };
}

class StartWorkName {
  var startWork;

  StartWorkName({
    this.startWork,
  });

  factory StartWorkName.fromJson(Map<String, dynamic> json) => StartWorkName(
    startWork: json["start_work"],
  );

  Map<String, dynamic> toJson() => {
    "start_work": startWork,
  };
}

class StrengthsName {
  var strengths;

  StrengthsName({
    this.strengths,
  });

  factory StrengthsName.fromJson(Map<String, dynamic> json) => StrengthsName(
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "strengths": strengths,
  };
}

class WorkExpJob {
  var workExpJob;
  var companyName;
  var jobStartDate;
  var jobEndDate;

  WorkExpJob({
    this.workExpJob,
    this.companyName,
    this.jobStartDate,
    this.jobEndDate,
  });

  factory WorkExpJob.fromJson(Map<String, dynamic> json) => WorkExpJob(
    workExpJob: json["work_exp_job"],
    companyName: json["company_name"],
    jobStartDate: json["job_start_date"] ,
        // == null ? json["job_start_date"] : DateTime.parse(json["job_start_date"]),
    jobEndDate: json["job_end_date"]
        // == null ? json["job_end_date"] : DateTime.parse(json["job_end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "work_exp_job": workExpJob,
    "company_name": companyName,
    "job_start_date": "$jobStartDate" ,
        // ?.year.toString().padLeft(4, '0')}-${jobStartDate?.month.toString().padLeft(2, '0')}-${jobStartDate?.day.toString().padLeft(2, '0')}",
    "job_end_date": "$jobEndDate" ,
    // ?.year.toString().padLeft(4, '0')}-${jobEndDate?.month.toString().padLeft(2, '0')}-${jobEndDate?.day.toString().padLeft(2, '0')}",
  };
}

class SeekerInfo {
  var id;
  var profileImg;
  var fullname;
  var email;
  var password;
  var location;
  var aboutMe;
  var resume;
  dynamic totalExperience;
  var referralCode;
  dynamic referralBy;
  var status;
  String? documentType ;
  String? documentImg ;
  dynamic staupType;
  dynamic resetPassOtp;
  dynamic signupOtp;
  dynamic otpTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  SeekerInfo({
    this.id,
    this.profileImg,
    this.fullname,
    this.email,
    this.password,
    this.location,
    this.aboutMe,
    this.resume,
    this.totalExperience,
    this.referralCode,
    this.referralBy,
    this.status,
    this.documentType ,
    this.documentImg ,
    this.staupType,
    this.resetPassOtp,
    this.signupOtp,
    this.otpTime,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerInfo.fromJson(Map<String, dynamic> json) => SeekerInfo(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    location: json["location"],
    aboutMe: json["about_me"],
    resume: json["resume"],
    totalExperience: json["total_experience"],
    referralCode: json["referral_code"],
    referralBy: json["referral_by"],
    status: json["status"],
    staupType: json["staup_type"],
    resetPassOtp: json["reset_pass_otp"],
    signupOtp: json["signup_otp"],
    otpTime: json["otp_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    documentType: json["document_type"] ,
    documentImg: json["document_img"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
    "email": email,
    "password": password,
    "location": location,
    "about_me": aboutMe,
    "resume": resume,
    "total_experience": totalExperience,
    "referral_code": referralCode,
    "referral_by": referralBy,
    "status": status,
    "staup_type": staupType,
    "reset_pass_otp": resetPassOtp,
    "signup_otp": signupOtp,
    "otp_time": otpTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
