
import 'dart:convert';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class SeekerCreateProfileController extends GetxController {


  RxBool loading = false.obs;
  RxBool submitted = false.obs;
  var errorMessage = ''.obs ;
  var imageErrorMessage = ''.obs ;
  var cvErrorMessage = ''.obs ;
  var documentErrorMessage = ''.obs ;
  var languageErrorMessage = ''.obs ;
  var selectStartDateExperienceErrorMessage = ''.obs ;
  var selectStartDateEducationErrorMessage = ''.obs ;

  createProfileApi (
      String? profilePath ,
      String? resumePath ,
      String? documentPath,
      var  name ,
      var  location ,
      var  aboutMe ,
      var  workExperience ,
      var  education ,
      var  language ,
      var  appreciation ,
      var documentType,
      var fresher

      ) async {
    try {
      print(profilePath) ;
      print(workExperience);
      loading(true) ;
      var url = Uri.parse(AppUrl.seekerCreateProfile) ;
      print(url) ;
      var sp = await SharedPreferences.getInstance() ;
      var request = http.MultipartRequest('POST' , url ) ;

      final formData = fresher == null ?
      <String, dynamic>{
        'name': name,
        'location': location,
        'about_me': aboutMe,
        'work_exp_job': jsonEncode(workExperience),
        'education_level': jsonEncode(education),
        'language': jsonEncode(language),
        'appreciation': jsonEncode(appreciation),
        'document_type' :documentType,
      }:
      <String, dynamic>{
        'name': name,
        'location': location,
        'about_me': aboutMe,
        'work_exp_job': jsonEncode(workExperience),
        'education_level': jsonEncode(education),
        'language': jsonEncode(language),
        'appreciation': jsonEncode(appreciation),
        'document_type' :documentType,
        'fresher' : jsonEncode(fresher)
      };

      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      if( profilePath != null && profilePath.isNotEmpty) { request.files.add(await http.MultipartFile.fromPath("profile_img" , profilePath )) ; }
      if( resumePath != null && resumePath.isNotEmpty) {  request.files.add(await http.MultipartFile.fromPath("resume" , resumePath )) ; }
      if( documentPath != null && documentPath.isNotEmpty) { request.files.add(await http.MultipartFile.fromPath("document_img" , documentPath )) ; }
      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}" ;
      var response = await request.send() ;
      print(response.statusCode) ;
      print(request.files) ;
      print(request.fields) ;
      var responded = await http.Response.fromStream(response) ;
      print(response.statusCode) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        print(responseData) ;

        Get.offAll(const TabScreen(index: 4));
      }
     else {
        // errorMessage.value = responseData["message"] ;
      }
      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      print(e.toString()) ;
      print(stackTrace) ;
    }
  }

}