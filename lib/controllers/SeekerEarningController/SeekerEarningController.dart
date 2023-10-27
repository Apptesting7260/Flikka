
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';
import 'package:get/get.dart';
import '../../repository/SeekerDetailsRepository/SeekerRepository.dart';

class SeekerEarningController extends GetxController {

  final _api = SeekerRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final getEarningDetails =SeekerEarningModel().obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerEarnings(SeekerEarningModel _value) => getEarningDetails.value = _value ;
  void setError(String _value) => error.value = _value ;


  void seekerEarningApi(){
    setRxRequestStatus(Status.LOADING);

    _api.getWalletApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getEarningDetails(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}