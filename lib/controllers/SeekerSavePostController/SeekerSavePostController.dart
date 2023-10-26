
import 'package:flikka/repository/SeekerDetailsRepository/JobsRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeekerSavePostController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  savePostApi(
      dynamic id ,
      dynamic type ,
      ) async{
    loading(true) ;
    Map data =  {
      'id' : "$id" ,
      'type' : "$type"
    };
    print(data);

    _api.seekerSaveJobPost(data).then((value){
      loading(false) ;
      if(value.status!){
        Get.back() ;
        Utils.toastMessage('Post saved') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back() ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      Get.back() ;
    }) ;
  }
}