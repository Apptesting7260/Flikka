import 'package:flikka/Payment_Methods/add_bank_account_details.dart';
import 'package:flikka/Payment_Methods/bank_account_details_edit.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/PaymentRequestController/PaymentRequestController.dart';
import '../controllers/SeekerEarningController/SeekerEarningController.dart';


class RequestWithdraw extends StatefulWidget {
  const RequestWithdraw({super.key});

  @override
  State<RequestWithdraw> createState() => _RequestWithdrawState();
}

class _RequestWithdrawState extends State<RequestWithdraw> {

  PaymentRequestController paymentRequestController =Get.put(PaymentRequestController()) ;
  TextEditingController amountController = TextEditingController() ;

  SeekerEarningController seekerEarningController = Get.put(SeekerEarningController()) ;
  var formKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back() ;
            },
              child: Image.asset("assets/images/icon_back_blue.png")),
          title: Text("Request Withdraw", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          toolbarHeight: 45,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: Get.height*.02,) ,
              Text("£ ${seekerEarningController.getEarningDetails.value.totalAmount ?? 0}",style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.blueThemeColor,fontSize: 30)),
                SizedBox(height: Get.height*0.001,),
                Text("Your balance",style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: Get.height*0.01,),
                GestureDetector(
              onTap: () {
              Get.to(()=>EditBankAccountDetail());
              },
              child: Text("See Account Details",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.blueThemeColor))),
              // Container(
              //   height: Get.height*0.07,
              //   width: Get.width*0.8,
              //   decoration: BoxDecoration(
              //       color: Color.fromRGBO(69, 69, 69, 1),
              //       borderRadius: BorderRadius.circular(60)
              //   ),
              //   child: Row(children: [
              //     Container(
              //       width: Get.width*0.15,
              //       height: Get.height,
              //       alignment: Alignment.center,
              //       decoration: const BoxDecoration(
              //         color: AppColors.blueThemeColor,
              //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),topLeft: Radius.circular(60))),
              //       child:Text("£",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w500,fontSize: 26),),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left:16.0),
              //       child: Container(
              //         width: Get.width*0.5,
              //         child: TextFormField(
              //           controller: amountController,
              //           style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
              //           decoration: InputDecoration(
              //             fillColor: Color(0xff454545),
              //             border: UnderlineInputBorder(borderSide: BorderSide.none),
              //           ),
              //           validator: (value) {
              //             if(value == null || value.isEmpty) {
              //               return "This field is required" ;
              //             }
              //           },
              //         ),
              //       ),
              //     ),
              //   ],),
              //
              // ),
                SizedBox(height: Get.height*0.05,),
                TextFormField(
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
                  controller: amountController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    filled: true,
                    fillColor: Color(0xff454545),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 13),
                          decoration: BoxDecoration(
                            color: AppColors.blueThemeColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(33),
                            bottomLeft: Radius.circular(33))
                          ),
                          width: 42,
                          height: 55,
                          child: Center(
                            child: Text("£",style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.white,fontWeight: FontWeight.w500)),

                          ),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter your amount" ;
                    }
                  },
                ),
                SizedBox(height: Get.height*0.03,),
              Obx( () =>
                 MyButton(
                   loading: paymentRequestController.loading.value,
                  width: Get.width*.66,
                  title: "CONTINUE", onTap1: () {
                     if(formKey.currentState!.validate()) {
                       paymentRequestController.paymentRequestApiHit(amountController.text) ;
                     }
                  // Get.to(() =>AddBankAccountDetails());
                },),
              )
            ],),
          ),
        ),
      ),
    );
  }
}