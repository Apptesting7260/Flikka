

import 'package:flikka/Payment_Methods/add_bank_account_details.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/SeekerEarningModel/SeekerEarningModel.dart';


class PaymentRequestController extends GetxController {
  final _api = AuthRepository();

  String ?amount;
  RxBool loading = false.obs;

  final getEarningDetails =SeekerEarningModel().obs ;

  Future<void> paymentRequestApiHit(
    String amount ,
       BuildContext context
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

      if(value.status == true) {
        Get.to(AddBankAccountDetails()) ;
      }else if(value.status == false) {
      paymentDialog(context) ;
      }
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
  paymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child:  Padding(
            padding: EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Please fill a valid amount")) ,
              SizedBox(height: 15,) ,
                Center(
                  child: MyButton(
                    width: Get.width*.3,
                    height: Get.height*.055,
                    title: "Ok", onTap1: () {
                      Get.back() ;
                  },),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}