
import 'dart:convert';

import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/Job%20Recruiter/ViewRecruiterJob.dart';
import 'package:get/get.dart';
import '../../Job Seeker/Authentication/user/create-profile.dart';
import '../../data/response/status.dart';
import '../../repository/Auth_Repository.dart';
import '../../utils/utils.dart';

class RequiredSkillsController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  var errorMessage = "".obs ;

  requiredSkillsApi (
      List? skills ,
      List? strengths ,
      List? passion ,
      List? industryPreference ,
      var salaryExpectation  ,
      List? startWork ,
      List? availability
      ) {
    loading(true) ;
    setRxRequestStatus(Status.LOADING);
    var data = {
      "skill_id" : jsonEncode(skills) ,
      "strength_id" : jsonEncode(strengths),
      "passion_id" : jsonEncode(passion),
      "industry_preference_id" : jsonEncode(industryPreference),
      "salary_expectation_id" : jsonEncode(salaryExpectation) ,
      "start_work_id" : jsonEncode(startWork),
      "availabity_id" : jsonEncode(availability),

    };
    print(skills);

    _api.requiredSkillsApi(data).then((value){
      loading(false) ;
      // print(value);
      Get.offAll(TabScreenEmployer(index: 4, profileTabIndex: 2,));
  // Get.to(()=>const CompanyRecruiter());
      // Utils.snackBar( "Message",value.message);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);
      // Utils.snackBar('Failed',error);
    });
  }

}