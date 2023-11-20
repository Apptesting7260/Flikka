import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/models/ApplicantTrackingDataModel/ApplicantTrackingDataModel.dart';
import 'package:flikka/models/SeekerSavedPostModel/SeekerSavedPostModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';

class ApplicantTrackingDataController extends GetxController {

  final _api = RecruiterRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  var applicantTrackingDataModel = ApplicantTrackingDataModel().obs ;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  void setError(String value) => error.value = value ;

  applicantTrackingApi(dynamic jobTitle , dynamic status )
  async{
    setRxRequestStatus(Status.LOADING);
    var data =  {};
    data.addIf(jobTitle != null && jobTitle.toString().isNotEmpty, "job_title", jobTitle) ;
    data.addIf(status != null && status.toString().isNotEmpty, "candidate_status_type", status) ;


    debugPrint(data.toString());
    _api.applicantTrackingData(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      applicantTrackingDataModel(value) ;

    }).onError((error, stackTrace){
      setError(error.toString());
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    }) ;
  }

  refreshApi(dynamic jobTitle , dynamic status) async{
    loading(true) ;
    var data =  {};
    data.addIf(jobTitle != null && jobTitle.toString().isNotEmpty, "job_title", jobTitle) ;
    data.addIf(status != null && status.toString().isNotEmpty, "candidate_status_type", status) ;

    debugPrint(data.toString());
    _api.applicantTrackingData(data).then((value){
      loading(false) ;
      applicantTrackingDataModel(value) ;

    }).onError((error, stackTrace){
      loading(false) ;

    }) ;
  }
}