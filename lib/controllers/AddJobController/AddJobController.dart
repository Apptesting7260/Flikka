import 'dart:convert';
import 'package:flikka/Job%20Recruiter/RecruiterRequiredSkills/required_skills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class AddJobController extends GetxController {


  RxBool loading = false.obs;
  RxBool submitted = false.obs;
  var featureImageError = ''.obs ;
  var jobPositionErrorMessage = ''.obs ;
  var jobTypeErrorMessage = ''.obs ;
  var typeOfWorkPlaceErrorMessage = ''.obs ;
  var qualificationErrorMessage = '' .obs ;
  var languageErrorMessage = '' .obs ;

  addJobApi (
      String? profilePath ,
      var  position ,
      var  jobTitle ,
      var  specialization ,
      var  location ,
      var  description ,
      var  requirements ,
      var  jobType ,
      var  workplace ,
      var  experience ,
      var  preferredExperience ,
      var  qualification ,
      var  language ,

   { var jobId,
  RecruiterJobsData? recruiterJobsData
  }) async {
    try {
      debugPrint(jobType.toString());
      debugPrint("this is profile path =================$profilePath");
      loading(true) ;
      var url = Uri.parse(AppUrl.addUpdateJob) ;
      debugPrint(url.toString()) ;
      var sp = await SharedPreferences.getInstance() ;
      var request = http.MultipartRequest('POST' , url ) ;

      final formData = jobId != null ?  {
        'job_title': jobTitle,
        'job_position': position,
        'specialization': specialization ,
        'job_location': location,
        'description': description,
        'employment_type': jobType,
        'type_of_workplace': workplace,
        'requirements': requirements,
        'work_experience': experience,
        'preferred_work_experience': preferredExperience,
        'education': qualification,
        'language': jsonEncode(language),
        'job_id':jobId
      }:{
        'job_title': jobTitle,
        'job_position': position,
        'specialization': specialization ,
        'job_location': location,
        'description': description,
        'employment_type': jobType,
        'type_of_workplace': workplace,
        'requirements': requirements,
        'work_experience': experience,
        'preferred_work_experience': preferredExperience,
        'education': qualification,
        'language': jsonEncode(language),
      };
      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      if(profilePath != null) {
        debugPrint("inside multipart") ;
      request.files.add(await http.MultipartFile.fromPath("feature_img" , profilePath)) ; }
      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}" ;
      var response = await request.send() ;
      debugPrint(response.statusCode.toString()) ;
      debugPrint(request.files.toString()) ;
      debugPrint(request.fields.toString()) ;
      var responded = await http.Response.fromStream(response) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        debugPrint(responseData.toString()) ;
        if(recruiterJobsData != null) {
          print("called function 1") ;
          Get.to( () => RequiredSkills(recruiterJobsData: recruiterJobsData,) , arguments: {"job_id" : responseData["job_id"] });
        } else if (recruiterJobsData == null) {
        Get.to( () => const RequiredSkills() , arguments: {"job_id" : responseData["job_id"] }); }
      } else {
      }
      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      debugPrint(e.toString()) ;
      debugPrint(stackTrace.toString()) ;
    }
  }

}