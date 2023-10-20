
import 'dart:convert';

import 'package:get/get.dart';
import '../../Job Seeker/Authentication/user/create-profile.dart';
import '../../repository/Auth_Repository.dart';
import '../../utils/utils.dart';

class SeekerChooseSkillsController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  seekerSkillsApi (
      List? skills ,
      List? strengths ,
      List? passion ,
      List? industryPreference ,
      var salaryExpectation  ,
      List? startWork ,
      List? availability
     ) {

    loading(true) ;

    var data = {

      "skill_id" : jsonEncode(skills) ,
      "strength_id" : jsonEncode(strengths),
      "passion_id" : jsonEncode(passion),
      "industry_preference_id" : jsonEncode(industryPreference),
      "salary_expectation_id" : salaryExpectation,
      "start_work_id" : jsonEncode(startWork),
      "availabity_id" : jsonEncode(availability),
    };
    print(skills.toString());

    _api.seekerChooseSkillsApi(data).then((value){
      loading(false) ;
      // print(value);

      // Utils.snackBar( "Message",value.message.toString());

      Get.to(() => const CreateProfile());

    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      errorMessage.value = error.toString() ;
      // Utils.snackBar('Failed',error.toString());
    });
  }

}