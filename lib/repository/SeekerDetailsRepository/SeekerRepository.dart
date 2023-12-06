
import 'package:flikka/models/CompanyListModel/CompanyListModel.dart';
import 'package:flikka/models/SeekerAppliedJobsModel/SeekerAppliedJobsModel.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';
import 'package:flikka/models/SeekerJobFilterModel/SeekerJobFilterModel.dart';
import 'package:flikka/models/SeekerSavedPostModel/SeekerSavedPostModel.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';

import '../../data/network/network_api_services.dart';
import '../../models/EditAboutModel/EditAboutModel.dart';
import '../../models/GetJobsListingModel/GetJobsListingModel.dart';
import '../../models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';
import '../../models/SeekerMapJobsModel/SeekerMapJobsModel.dart';
import '../../models/SeekerViewInterviewAll/SeekerViewInterviewAll.dart';
import '../../res/app_url.dart';

class SeekerRepository {
  final apiServices = NetworkApiServices() ;

  Future<GetJobsListingModel> getJobsListingApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.getJobsListing);
    return GetJobsListingModel.fromJson(response);
  }

  Future<SeekerEarningModel> getWalletApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.seekerEarningDetails);
    return SeekerEarningModel.fromJson(response);
  }

  Future<CompanyListModel> companiesListApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.companiesList);
    return CompanyListModel.fromJson(response);
  }

  Future<SeekerSavedJobsListModel> seekerSavedJobsListApi(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.seekerSavedJobsList);
    return SeekerSavedJobsListModel.fromJson(response);
  }

  Future<ViewRecruiterProfileModel> seekerViewCompanyDetail(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.seekerViewCompanyDetails);
    return ViewRecruiterProfileModel.fromJson(response);
  }

  Future<SeekerJobFilterModel> seekerJobFilterApi(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.getFilteredJobsListing);
    return SeekerJobFilterModel.fromJson(response);
  }

  Future<EditAboutModel> seekerSaveJobPost(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerSaveJob);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> seekerPostReview(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerPostReview);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerSalaryExpectation(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.editSeekerSalary);
    return EditAboutModel.fromJson(response);
  }

  Future<EditAboutModel> editSeekerSoftSkill(var data , int number) async {
    dynamic response = await apiServices.postApi2(data,
      number == 1 ?  AppUrl.editSeekerSoftSkills :
          number == 2 ? AppUrl.editSeekerPassion :
              number == 3 ? AppUrl.editSeekerIndustryPreference :
                  number == 4 ? AppUrl.editSeekerStrength :
                      number == 5 ? AppUrl.editSeekerStartWork :
                          AppUrl.editSeekerAvailability );
    return EditAboutModel.fromJson(response);
  }

  Future<SeekerAppliedJobsModel> appliedJobsApi() async{
    dynamic response = await apiServices.getApi2(AppUrl.seekerAppliedJobs);
    return SeekerAppliedJobsModel.fromJson(response);
  }

  Future<SeekerMapJobsModel> getNearByJobs() async{
    dynamic response = await apiServices.getApi2(AppUrl.seekerNearByJobs);
    return SeekerMapJobsModel.fromJson(response);
  }

  Future<EditAboutModel> seekerUpdateRequestedJobStatus(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerUpdateRequestedJobStatus);
    return EditAboutModel.fromJson(response);
  }

  Future<SeekerViewInterviewModel> getInterviewList(var data) async{
    dynamic response = await apiServices.postApi2(data,AppUrl.seekerInterviewList);
    return SeekerViewInterviewModel.fromJson(response);
  }
}