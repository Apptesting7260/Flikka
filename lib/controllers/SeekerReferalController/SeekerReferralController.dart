
import 'package:flikka/Job%20Seeker/Role_Choose/import_cv.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/location_pop_up.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';


class SeekerReferralController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;


   referralApi(
      var referralCode ,
      var role ,

      )  {
    loading.value = true ;
    Map data = {
      'referral_code' : referralCode,
      'role' :role.toString()
    };
    _api.seekerReferral(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        Get.off(() => role == 0 ? const LocationPopUp() : ImportCv(role: role)) ;
      }
      // Utils.snackBar( "Message",value.message.toString());
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
      // Utils.showApiErrorDialog(context, error.toString()) ;
    });
  }
}