
import 'package:flikka/models/CompanyListModel/CompanyListModel.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';

import '../../data/network/network_api_services.dart';
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
}