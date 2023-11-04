import 'package:flikka/data/network/network_api_services.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import '../../res/app_url.dart';

class RecruiterRepository {
  final apiServices = NetworkApiServices() ;

  Future<EditAboutModel> deleteJob(var data) async{
    dynamic response = await apiServices.postApi2( data,AppUrl.recruiterDeleteJob);
    return EditAboutModel.fromJson(response);
  }
}