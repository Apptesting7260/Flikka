
import '../SeekerAppliedJobsModel/SeekerAppliedJobsModel.dart';

class SeekerMapJobsModel {
  bool? status;
  List<AppliedJobsList>? jobs;

  SeekerMapJobsModel({
    this.status,
    this.jobs
}) ;

  factory SeekerMapJobsModel.fromJson(Map<String, dynamic> json) => SeekerMapJobsModel(
    status: json["status"],
    jobs: json["jobs"] == null ? json["jobs"] : List<AppliedJobsList>.from(json["jobs"].map((x) => AppliedJobsList.fromJson(x))),
  );

}