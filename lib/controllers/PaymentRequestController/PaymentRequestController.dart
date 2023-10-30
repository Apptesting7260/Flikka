
import 'package:flikka/Payment_Methods/add_bank_account_details.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/SeekerEarningModel/SeekerEarningModel.dart';


class PaymentRequestController extends GetxController {
  final _api = AuthRepository();

  String ?amount;
  RxBool loading = false.obs;

  final getEarningDetails =SeekerEarningModel().obs ;

  Future<void> paymentRequestApiHit(
    String amount
      ) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    loading.value = true ;
    Map data = {
      'amount' : amount,
    };
    print(data);
    print(amount) ;
    _api.paymentRequestApi(data).then((value){
      loading.value = false ;
      print(value);

      Get.to(AddBankAccountDetails()) ;
      // else {
      //
      //   //Utils.snackBar( "Message",value.message.toString());
      // }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}