
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditSeekerResumeController extends GetxController {

  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  resumeApi(
      String resume ,
      BuildContext context
      ) async {
    try {
      loading.value = true;
      var sp = await SharedPreferences.getInstance();
      var url = Uri.parse(AppUrl.editSeekerResume);
      var request = http.MultipartRequest('POST', url);

        request.files.add(await http.MultipartFile.fromPath("resume", resume));

      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}";
      var response = await request.send();
      var responded = await http.Response.fromStream(response);
      var responseData = jsonDecode(responded.body);
      if (response.statusCode == 200) {
        loading(false);
        seekerProfileController.viewSeekerProfileApi();
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              width: 130,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
              elevation: 10,
              content: Text('Profile updated'),
            ));
        if (kDebugMode) {
          print(responseData['message']);
        }
      }
      loading(false);
    } catch (e) {
      loading(false);
      if (kDebugMode) {
        print(e.toString()) ;
      }
    }
  }
}