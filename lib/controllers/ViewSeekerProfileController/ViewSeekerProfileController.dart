import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';


class ViewSeekerProfileController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerData = ViewSeekerProfileModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeeker(ViewSeekerProfileModel _value) => viewSeekerData.value = _value ;
  void setError(String _value) => error.value = _value ;


   viewSeekerProfileApi() async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.viewSeekerProfile().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeekerData(value);
      loading(false) ;
      print(value);
      print("this is experience data =========== ${value.workExpJob?.length }") ;

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}