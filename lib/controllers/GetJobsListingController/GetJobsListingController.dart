
import 'package:get/get.dart';
import '../../../data/response/status.dart';
import '../../models/GetJobsListingModel/GetJobsListingModel.dart';
import '../../repository/SeekerDetailsRepository/JobsRepository.dart';

class GetJobsListingController extends GetxController {

  final _api = SeekerRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final getJobsListing =GetJobsListingModel().obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerGetJobs(GetJobsListingModel _value) => getJobsListing.value = _value ;
  void setError(String _value) => error.value = _value ;


  void seekerGetAllJobsApi(){
    setRxRequestStatus(Status.LOADING);

    _api.getJobsListingApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getJobsListing(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      setRxRequestStatus(Status.ERROR);

    });
  }

}