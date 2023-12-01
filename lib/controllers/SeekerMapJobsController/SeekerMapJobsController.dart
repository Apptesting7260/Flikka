
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';
import 'package:flikka/models/SeekerMapJobsModel/SeekerMapJobsModel.dart';
import 'package:get/get.dart';
import '../../repository/SeekerDetailsRepository/SeekerRepository.dart';

class SeekerMapJobsController extends GetxController {

  final _api = SeekerRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final jobsData = SeekerMapJobsModel().obs ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerEarnings(SeekerMapJobsModel _value) => jobsData.value = _value ;
  void setError(String _value) => error.value = _value ;


  void mapJobsApi(){
    setRxRequestStatus(Status.LOADING);

    _api.getNearByJobs().then((value){
      setRxRequestStatus(Status.COMPLETED);
      jobsData(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

  void refreshApi(){
    // setRxRequestStatus(Status.LOADING);
    refreshLoading(true) ;
    _api.getNearByJobs().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      jobsData( value);
      refreshLoading(false) ;
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      refreshLoading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}