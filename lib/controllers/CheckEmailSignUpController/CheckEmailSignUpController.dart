
import 'package:flikka/Job%20Seeker/Authentication/otp.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Job Seeker/Authentication/sign_up.dart';

class CheckEmailSignUpController extends GetxController {

  final _api = AuthRepository();


  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  void checkEmailSignUpApiHit(String email) async{
    loading.value = true ;

    Map data = { 'email' : email,};
    print(data);
    print("Dataaaaaaaaaaaaaaa");
    _api.checkEmailSignUpApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        // Utils.snackBar( "Message",value.message.toString());
        Get.to(() => const OtpScreen(register: true) , arguments: {"email": email}) ;
      }
      else{
     errorMessage.value =  value.message.toString();
      }
      // Get.to(TabScreen(index: 0));
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}