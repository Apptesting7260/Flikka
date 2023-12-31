
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:get/get.dart';

class GetJobsListingController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final getJobsListing = GetJobsListingModel().obs ;
  RxList<SeekerJobsData>? jobs = <SeekerJobsData>[].obs ;
  RxString error = ''.obs;
  RxBool saved = false.obs ;
  RxBool applied = false.obs ;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  void seekerGetJobs(GetJobsListingModel value) => getJobsListing.value = value ;
  void setError(String value) => error.value = value ;

  void seekerGetAllJobsApi(){
    setRxRequestStatus(Status.LOADING);
    _api.getJobsListingApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      seekerGetJobs(value);
      jobs?.value = value.jobs ?? [] ;
      print("this is length ===== ${value.jobs?.length}") ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }


  void refreshJobsApi(){
    // setRxRequestStatus(Status.LOADING);
    _api.getJobsListingApi().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      jobs?.value = value.jobs ?? [] ;
      getJobsListing(value);

      print("this is length ===== ${getJobsListing.value.jobs?.length}") ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      // setRxRequestStatus(Status.ERROR);
    });
  }
}