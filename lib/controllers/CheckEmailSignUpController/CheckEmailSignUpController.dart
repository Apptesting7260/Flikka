
import 'package:flikka/Job%20Seeker/Authentication/otp.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CheckEmailSignUpController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  void checkEmailSignUpApiHit(
      String email,
      BuildContext context
      ) async{
    loading.value = true ;

    Map data = { 'email' : email,};
    if (kDebugMode) {
      print(data);
    }
    _api.checkEmailSignUpApi(data).then((value){
      loading.value = false ;
      if (kDebugMode) {
        print(value);
      }
      if(value.status!){
       Utils.toastMessage("otp sent successfully") ;
        Get.to(() => const OtpScreen(register: true) , arguments: {"email": email}) ;
      }
      else{
     errorMessage.value =  value.message.toString();
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      loading.value = false ;
      Utils.showApiErrorDialog(context, error.toString()) ;
    });
  }
}