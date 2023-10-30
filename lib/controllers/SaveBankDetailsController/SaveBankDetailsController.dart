
import 'package:flikka/Payment_Methods/add_bank_account_details.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Job Seeker/Authentication/create_password.dart';
import '../../models/SeekerEarningModel/SeekerEarningModel.dart';


class SaveBankDetailsController extends GetxController {
  final _api = AuthRepository();

  RxBool loading = false.obs;

  var bankName ;
  // final accountHolderController = TextEditingController().obs;
  // final branchCodeController = TextEditingController().obs;
  // final accountNumberController = TextEditingController().obs;

  Future<void> SaveBankDetailsApiHit(
      var bankName,
      var accountHolder,
      var branchCode,
      var accountNumber,
      var ifscCode,
      ) async {

    loading.value = true ;
    Map data = {
      'bank_name' : bankName.toString(),
      'account_holder' : accountHolder,
      'branch_code' : branchCode,
      'account_number' : accountNumber,
      'IFSC_code' : ifscCode,

    };
    print(data);

    _api.SaveBankDetailsApi(data).then((value){
      loading.value = false ;
      print(value);

      // Get.to(AddBankAccountDetails()) ;

    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}