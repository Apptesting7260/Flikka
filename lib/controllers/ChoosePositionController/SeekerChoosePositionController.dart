
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Job Seeker/Role_Choose/choose_skills.dart';


class SeekerChoosePositionController extends GetxController {

  final _api = AuthRepository();

  final positioncontroller = TextEditingController().obs;

  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  Future<void> seekerChoosePositionApiHit(
      var id
      ) async {
    print("$id");
    loading.value = true ;

    print(loading.value);
    Map data = {
      'position_id' :id.toString(),
    };
    print(data);

    _api.SeekerChoosePositionApi(data).then((value){
      loading.value = false ;
      print(value);
      print("dataaaaa");

      // Utils.snackBar( "Message",value.message.toString());

      Get.to(() => const ChooseSkills());
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      errorMessage.value = error.toString() ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}