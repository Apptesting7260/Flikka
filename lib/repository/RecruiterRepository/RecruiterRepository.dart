import 'package:flikka/data/network/network_api_services.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/models/RecruiterHomeModel/RecruiterHomeModel.dart';
import 'package:flikka/models/RecuiterJobTitleModel/RecruiterJobTitleModel.dart';
import 'package:flikka/models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';
import 'package:flikka/models/TalentPoolModel/TalentPoolModel.dart';
import 'package:flikka/models/ViewParticularCandidateModel/ViewParticularCandidateModel.dart';
import '../../models/ApplicantTrackingDataModel/ApplicantTrackingDataModel.dart';
import '../../res/app_url.dart';

class RecruiterRepository {
  final apiServices = NetworkApiServices() ;

  Future<EditAboutModel> deleteJob(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.recruiterDeleteJob);
    return EditAboutModel.fromJson(response);
  }


  Future<ApplicantTrackingDataModel> applicantTrackingData(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.applicantTrackingData);
    return ApplicantTrackingDataModel.fromJson(response);
  }

  Future<ViewParticularCandidateModel> viewParticularCandidate(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.viewParticularCandidate);
    return ViewParticularCandidateModel.fromJson(response);
  }

  Future<EditAboutModel> scheduleInterview(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.scheduleInterview);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> candidateJobStatus(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.candidateJobStatus);
    return EditAboutModel.fromJson(response);
  }

  Future<RecruiterJobTitleModel> getJobTitleApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.recruiterJobTitle);
    return RecruiterJobTitleModel.fromJson(response);
  }

  Future<ScheduledInterviewListModel> getInterviewList(var data) async{
    dynamic response = await apiServices.postApi2(data,AppUrl.scheduledInterviewList);
    return ScheduledInterviewListModel.fromJson(response);
  }

  Future<ScheduledInterviewListModel> getRequestedSeekersList() async{
    dynamic response = await apiServices.getApi2(AppUrl.requestedSeekers);
    return ScheduledInterviewListModel.fromJson(response);
  }

  Future<RecruiterHomeModel> recruiterHomeApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.recruiterHomePage);
    return RecruiterHomeModel.fromJson(response);
  }

  Future<TalentPoolModel> talentPoolApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.talentPoolList);
    return TalentPoolModel.fromJson(response);
  }

  Future<EditAboutModel> addToPool(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.talentPoolSeeker);
    return EditAboutModel.fromJson(response);
  }

}