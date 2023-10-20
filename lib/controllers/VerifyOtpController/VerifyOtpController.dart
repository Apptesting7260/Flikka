
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Job Seeker/Authentication/create_password.dart';


class VerifyOtpController extends GetxController {

  final _api = AuthRepository();

  final emailController=TextEditingController().obs;
  final otpController=TextEditingController().obs;
  RxBool loading = false.obs;
  var verifyOtpErrorMessage = ''.obs ;


  Future<void> verifyOtpApiHit(
      var email
      ) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    loading.value = true ;
    print( emailController.value.text);
    Map data = {
      'email' : email,
      'otp' :otpController.value.text
    };
    print(data);
    _api.otpVerification(data).then((value){
      loading.value = false ;
      print(value);
      // BarrierToken=value.token;
      if(value.status) {
        Get.to( CreatePassword(email: email,));
        sp.setString("BarrierToken", "${value.token}") ;
      }
      else {
        verifyOtpErrorMessage.value = value.message.toString();
      //Utils.snackBar( "Message",value.message.toString());
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Utils.snackBar('Failed',error.toString());
    });
  }
}