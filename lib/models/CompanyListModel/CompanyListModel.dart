
import 'dart:convert';

CompanyListModel companyListModelFromJson(String str) => CompanyListModel.fromJson(json.decode(str));

String companyListModelToJson(CompanyListModel data) => json.encode(data.toJson());

class CompanyListModel {
  bool? status;
  List<CompanyList>? companyList;

  CompanyListModel({
    this.status,
    this.companyList,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
    status: json["status"],
    companyList: json["company_list"] == null ? json["company_list"] : List<CompanyList>.from(json["company_list"].map((x) => CompanyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "company_list": List<dynamic>.from(companyList!.map((x) => x.toJson())),
  };
}

class CompanyList {
  String? profileImg;
  String? companyName;
  String? companyLocation;

  CompanyList({
    this.profileImg,
    this.companyName,
    this.companyLocation,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    profileImg: json["profile_img"],
    companyName: json["company_name"],
    companyLocation: json["company_location"],
  );

  Map<String, dynamic> toJson() => {
    "profile_img": profileImg,
    "company_name": companyName,
    "company_location": companyLocation,
  };
}
