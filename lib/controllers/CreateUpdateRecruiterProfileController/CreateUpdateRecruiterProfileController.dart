
import 'dart:convert';
import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;


class CreateUpdateRecruiterProfileController extends GetxController {


  RxBool loading = false.obs;
  var errorMessage = ''.obs ;
  var profileImageError = ''.obs ;
  var coverImageError = ''.obs ;
  var industryError = ''.obs ;
  var companySizeError = ''.obs ;
  var foundedError = ''.obs ;

  createUpdateRecruiterProfileApi ({
    String? profilePath,
    String? coverPath,
    var companyName,
    var companyLocation,
    var addBio,
    var homeTitleName,
    var homeDescription,
    var websiteLink,
    var aboutTitleName,
    var aboutDescription,
    var industry,
    var companySize,
    var founded,
    var specialties,
    var contactPerson,
  } ) async {
    try {
      loading(true) ;
      var url = Uri.parse(AppUrl.CreateUpdateRecruiterProfileUrl) ;
      var request = http.MultipartRequest('POST' , url ) ;
      request.fields.addAll({
        "company_name":companyName ,
        "company_location":companyLocation ,
        "add_bio": addBio ,
        // "home_title": homeTitleName,
        "home_description": homeDescription,
        "website_link": websiteLink,
        // "about_title": aboutTitleName,
        "about_description": aboutDescription,
        "industry": industry.toString(),
        "company_size": companySize.toString(),
        "founded": jsonEncode(founded.toString()),
        "specialties": specialties,
        "contact_person" : contactPerson
      }) ;
      print(request.fields) ;
      request.files.add(await http.MultipartFile.fromPath("profile_img" , profilePath ?? "")) ;
      request.files.add(await http.MultipartFile.fromPath("cover_img" , coverPath ?? "")) ;
      SharedPreferences sp=await SharedPreferences.getInstance();
      request.headers["Authorization"] =" Bearer ${sp.getString("BarrierToken")}";
      var response = await request.send() ;
      print(response.statusCode) ;
      print(request.files) ;
      print(request.fields) ;
      var responded = await http.Response.fromStream(response) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        print(responseData) ;
        Get.offAll(TabScreenEmployer(index: 4,));
      }
      else {
          errorMessage.value = responseData["message"] ;
      }

      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      print(e.toString()) ;
      print(stackTrace) ;
    }
  }

}


