
import 'dart:convert';

import 'package:flikka/models/ViewLanguageModel/VIewLanguageModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../GetJobsListingModel/GetJobsListingModel.dart';

ViewRecruiterProfileModel viewRecruiterProfileModelFromJson(String str) => ViewRecruiterProfileModel.fromJson(json.decode(str));

String viewRecruiterProfileModelToJson(ViewRecruiterProfileModel data) => json.encode(data.toJson());

class ViewRecruiterProfileModel {
  bool? status;
  String? contactPerson;
  RecruiterProfileDetails? recruiterProfileDetails;
  RxList<RecruiterJobsData>? jobs;
  RxList<CompanyReviewsModel>? reviews;
  String? message;

  ViewRecruiterProfileModel({
    this.status,
    this.contactPerson,
    this.recruiterProfileDetails,
    this.jobs,
    this.reviews ,
    this.message,
  });

  factory ViewRecruiterProfileModel.fromJson(Map<String, dynamic> json) => ViewRecruiterProfileModel(
    status: json["status"],
    contactPerson: json["contact_person"],
    recruiterProfileDetails: json["recruiterProfileDetails"] == null ? json["recruiterProfileDetails"] : RecruiterProfileDetails.fromJson(json["recruiterProfileDetails"]),
    jobs: json["jobs"] == null ? json["jobs"] : RxList<RecruiterJobsData>.from(json["jobs"].map((x) => RecruiterJobsData.fromJson(x))),
    reviews: json["company_reviews"] == null ? json["company_reviews"] : RxList<CompanyReviewsModel>.from(json["company_reviews"].map((x) => CompanyReviewsModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "contact_person": contactPerson,
    "recruiterProfileDetails": recruiterProfileDetails?.toJson(),
    "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
    "message": message,
  };
}

class RecruiterJobsData {
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
  List<LanguageModel>? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? jobPositions;
  JobsDetail? jobsDetail;

  RecruiterJobsData({
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

  factory RecruiterJobsData.fromJson(Map<String, dynamic> json) => RecruiterJobsData(
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
    language: json["language_name"] == null ? json["language_name"] : List<LanguageModel>.from(json["language_name"].map((x) => LanguageModel.fromJson(x))),
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobPositions: json["job_positions"],
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : JobsDetail.fromJson(json["jobs_detail"]),
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
    "language_name": List<dynamic>.from(language!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_positions": jobPositions,
    "jobs_detail": jobsDetail?.toJson(),
  };
}

class RecruiterProfileDetails {
  dynamic id;
  dynamic recruiterId;
  String? profileImg;
  String? coverImg;
  String? companyName;
  String? companyLocation;
  String? addBio;
  dynamic homeTitle;
  String? homeDescription;
  String? websiteLink;
  dynamic aboutTitle;
  dynamic industryID;
  String? aboutDescription;
  String? industry;
  String? companySize;
  String? founded;
  String? specialties;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic avgReview ;
  dynamic totalReview ;

  RecruiterProfileDetails({
    this.id,
    this.recruiterId,
    this.profileImg,
    this.coverImg,
    this.companyName,
    this.companyLocation,
    this.addBio,
    this.homeTitle,
    this.homeDescription,
    this.websiteLink,
    this.aboutTitle,
    this.aboutDescription,
    this.industry,
    this.companySize,
    this.founded,
    this.specialties,
    this.createdAt,
    this.updatedAt,
    this.industryID ,
    this.avgReview,
    this.totalReview
  });

  factory RecruiterProfileDetails.fromJson(Map<String, dynamic> json) => RecruiterProfileDetails(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    profileImg: json["profile_img"],
    coverImg: json["cover_img"],
    companyName: json["company_name"],
    companyLocation: json["company_location"],
    addBio: json["add_bio"],
    homeTitle: json["home_title"],
    homeDescription: json["home_description"],
    websiteLink: json["website_link"],
    aboutTitle: json["about_title"],
    aboutDescription: json["about_description"],
    industry: json["industris"],
    industryID: json["industry"],
    companySize: json["company_size"],
    founded: json["founded"],
    avgReview: json["avg_review"],
    totalReview: json["total_reviews"],
    // founded: json["founded"].toString() == 'null' ? json["founded"] : (DateTime.parse(json["founded"].substring(0,20).toString())),
    specialties: json["specialties"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "profile_img": profileImg,
    "cover_img": coverImg,
    "company_name": companyName,
    "company_location": companyLocation,
    "add_bio": addBio,
    "home_title": homeTitle,
    "home_description": homeDescription,
    "website_link": websiteLink,
    "about_title": aboutTitle,
    "about_description": aboutDescription,
    "industris": industry,
    "industry": industryID ,
    "company_size": companySize,
    // "founded": "${founded?.year.toString().padLeft(4, '0')}-${founded?.month.toString().padLeft(2, '0')}-${founded?.day.toString().padLeft(2, '0')}",
    "specialties": specialties,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class CompanyReviewsModel {
  dynamic id;
  dynamic seekerId;
  dynamic recruiterId;
  String? description;
  dynamic stars;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SeekerInfo>? seekerInfo;
  List<SeekerDetailsInfo>? seekerDetailsInfo;

  CompanyReviewsModel({
    this.id,
    this.seekerId,
    this.recruiterId,
    this.description,
    this.stars,
    this.createdAt,
    this.updatedAt,
    this.seekerInfo,
    this.seekerDetailsInfo,
  });

  factory CompanyReviewsModel.fromJson(Map<String, dynamic> json) => CompanyReviewsModel(
    id: json["id"],
    seekerId: json["seeker_id"],
    recruiterId: json["recruiter_id"],
    description: json["discription"],
    stars: json["stars"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    seekerInfo: json["seeker_info"] == null ? json["seeker_info"] : List<SeekerInfo>.from(json["seeker_info"].map((x) => SeekerInfo.fromJson(x))),
    seekerDetailsInfo: json["seeker_details_info"] == null ? json["seeker_details_info"] : List<SeekerDetailsInfo>.from(json["seeker_details_info"].map((x) => SeekerDetailsInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "recruiter_id": recruiterId,
    "discription": description,
    "stars": stars,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "seeker_info": List<dynamic>.from(seekerInfo!.map((x) => x.toJson())),
    "seeker_details_info": List<dynamic>.from(seekerDetailsInfo!.map((x) => x.toJson())),
  };
}

class SeekerDetailsInfo {
  dynamic id;
  dynamic seekerId;
  String? position;
  String? positions;

  SeekerDetailsInfo({
    this.id,
    this.seekerId,
    this.position,
    this.positions,
  });

  factory SeekerDetailsInfo.fromJson(Map<String, dynamic> json) => SeekerDetailsInfo(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    positions: json["positions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "position": position,
    "positions": positions,
  };
}

class SeekerInfo {
  dynamic id;
  String? profileImg;
  String? fullname;

  SeekerInfo({
    this.id,
    this.profileImg,
    this.fullname,
  });

  factory SeekerInfo.fromJson(Map<String, dynamic> json) => SeekerInfo(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
  };
}

