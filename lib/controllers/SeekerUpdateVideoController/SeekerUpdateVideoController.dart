import 'dart:convert';
import 'package:flikka/Job%20Recruiter/RecruiterRequiredSkills/required_skills.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class SeekerUpdateVideoController extends GetxController {


  RxBool loading = false.obs;

  updateVideo (BuildContext context,String? videoPath) async {
    CommonFunctions.showLoadingDialog(context, "Uploading") ;
    try {
      debugPrint("this is profile path =================$videoPath");
      loading(true) ;
      var url = Uri.parse(AppUrl.seekerUpdateVideo) ;
      debugPrint(url.toString()) ;
      var sp = await SharedPreferences.getInstance() ;
      var request = http.MultipartRequest('POST' , url ) ;

      if(videoPath != null && videoPath.isNotEmpty) {
        debugPrint("inside multipart") ;
        request.files.add(await http.MultipartFile.fromPath("short_video" , videoPath)) ; }
      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}" ;
      var response = await request.send() ;
      debugPrint(response.statusCode.toString()) ;
      debugPrint(request.files.toString()) ;
      debugPrint(request.fields.toString()) ;
      var responded = await http.Response.fromStream(response) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        debugPrint(responseData.toString()) ;
        Get.back() ;
      loading(false) ; }
      Get.back() ;
    } catch ( e, stackTrace) {
      Get.back() ;
      loading(false) ;
      debugPrint(e.toString()) ;
      debugPrint(stackTrace.toString()) ;
      Utils.showMessageDialog(context, "oops! Something went wrong") ;
    }
  }

}