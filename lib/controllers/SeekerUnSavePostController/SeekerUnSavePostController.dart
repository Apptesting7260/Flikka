
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import 'package:flikka/controllers/SeekerAppliedJobsController/SeekerAppliedJobsController.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SeekerSavedJobsController/SeekerSavedJobsListController.dart';
import '../SeekerViewCompanyController/SeekerViewCompanyController.dart';

class SeekerUnSavePostController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  SeekerSavedJobsListController jobsListController = Get.put(SeekerSavedJobsListController()) ;

  unSavePost( String? jobId , String? type , BuildContext context) async{
    loading(true) ;
    var data =  {};
    data.addIf(jobId != null && jobId.length != 0 , 'job_id' , "$jobId" ) ;
    data.addIf(type != null && type.length != 0 , 'type' , "$type" ) ;

    _api.unSavePost(data).then((value){
      loading(false) ;
      if(value.status!){
        jobsListController.savePostApi("1") ;
        Get.back() ;
        Utils.toastMessage('Post removed') ;
      }
      Get.back() ;
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      loading(false) ;
      Get.back() ;
      Utils.showMessageDialog(context, "oops! something went wrong") ;
    });
  }
}