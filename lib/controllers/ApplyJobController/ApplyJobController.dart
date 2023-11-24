
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyJobController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  void applyJob(dynamic id , {
    String? seekerID
  }) async{
    loading.value = true ;

    var data = {
      'job_id' : id,
    };
    print(data);
    data.addIf(seekerID != null && seekerID.isNotEmpty , "seeker_id", seekerID) ;

    _api.applyJobApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        // Get.to(() => const ChooseRole()) ;
       seekerID == null ? Utils.toastMessage( "Successfully Applied") :
       Utils.toastMessage( "Profile Selected") ;
        Get.back() ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Utils.toastMessage( "${value.message}") ;
        Get.back() ;
      }
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      loading.value = false ;

    });
  }
}