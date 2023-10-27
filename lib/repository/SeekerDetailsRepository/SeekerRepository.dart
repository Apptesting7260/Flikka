
import 'package:flikka/models/CompanyListModel/CompanyListModel.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';
import 'package:flikka/models/SeekerSavedPostModel/SeekerSavedPostModel.dart';

import '../../data/network/network_api_services.dart';
import '../../models/EditAboutModel/EditAboutModel.dart';
import '../../models/GetJobsListingModel/GetJobsListingModel.dart';
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

  Future<EditAboutModel> seekerSaveJobPost(var data) async {
    dynamic response = await apiServices.postApi2(data, AppUrl.seekerSaveJob);
    return EditAboutModel.fromJson(response);
  }
}