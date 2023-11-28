import 'package:flikka/controllers/GetJobsListingController/GetJobsListingController.dart';
import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
import 'package:flikka/models/SeekerJobFilterModel/SeekerJobFilterModel.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';

class SeekerViewCompanyController extends GetxController {

  final _api = SeekerRepository();

  RxBool loading = false.obs;
  RxString error = ''.obs;
  var companyData = ViewRecruiterProfileModel().obs ;
  final rxRequestStatus = Status.LOADING.obs ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewCompany(
     String? recruiterID
      ) async{
    setRxRequestStatus(Status.LOADING) ;
    var data = {};
    data.addIf(recruiterID != null && recruiterID.toString().length != 0 , 'recruiter_id' , recruiterID) ;
    print(data);

    _api.seekerViewCompanyDetail(data).then((value){
      setRxRequestStatus(Status.COMPLETED) ;
      if(value.status!){
        companyData(value) ;
        print("this is value ==== $value") ;
        print("this is job id ==== ${companyData.value.jobs?[0].id.toString()}") ;
      }
    }).onError((error, stackTrace){
      setRxRequestStatus(Status.ERROR) ;
      setError(error.toString()) ;
      print(error);
    });
  }
}