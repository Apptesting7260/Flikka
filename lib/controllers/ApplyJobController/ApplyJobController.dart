
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';

class ApplyJobController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  void applyJop(
      String id
      ) async{
    loading.value = true ;

    Map data = {
      'job_id' : id,
    };
    print(data);

    _api.applyJobApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        // Get.to(() => const ChooseRole()) ;
        Utils.toastMessage( "Successfully Applied") ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Utils.toastMessage( "${value.message}") ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;

    });
  }
}