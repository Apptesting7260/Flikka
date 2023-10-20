
import 'dart:convert';
import 'package:flikka/Job%20Recruiter/RecruiterRequiredSkills/required_skills.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class AddJobController extends GetxController {


  RxBool loading = false.obs;
  RxBool submitted = false.obs;
  var featureImageError = ''.obs ;
  var jobPositionErrorMessage = ''.obs ;
  var jobTypeErrorMessage = ''.obs ;
  var typeOfWorkPlaceErrorMessage = ''.obs ;

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
      ) async {
    try {
      print(jobType);
      loading(true) ;
      var url = Uri.parse(AppUrl.addJob) ;
      print(url) ;
      var sp = await SharedPreferences.getInstance() ;
      var request = http.MultipartRequest('POST' , url ) ;

      final formData = <String, dynamic>{
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
        'language': language,
      };
      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      request.files.add(await http.MultipartFile.fromPath("feature_img" , profilePath ?? "")) ;
      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}" ;
      var response = await request.send() ;
      print(response.statusCode) ;
      print(request.files) ;
      print(request.fields) ;
      var responded = await http.Response.fromStream(response) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        print(responseData) ;
        print("this is ================= object") ;

       // Utils.snackBar("Success", responseData["message"]) ;
        Get.to( () => const RequiredSkills());
      } else {
        featureImageError.value = responseData["message"] ;
      }
      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      print(e.toString()) ;
      print(stackTrace) ;
    }
  }

}