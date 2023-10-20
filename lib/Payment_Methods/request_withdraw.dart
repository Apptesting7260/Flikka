import 'package:flikka/Payment_Methods/add_bank_account_details.dart';
import 'package:flikka/Payment_Methods/bank_account_details_edit.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RequestWithdraw extends StatefulWidget {
  const RequestWithdraw({super.key});

  @override
  State<RequestWithdraw> createState() => _RequestWithdrawState();
}

class _RequestWithdrawState extends State<RequestWithdraw> {
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          // SizedBox(height: Get.width*0.1,),

          Row(children: [
            SizedBox(width: Get.width*0.05,),
            Column(children: [
              GestureDetector(
                onTap: () {Get.back();}, // Image tapped
                child: Image.asset(
                  'assets/images/backicon.png',
                  // fit: BoxFit.cover, // Fixes border issues
                  width: Get.width*0.1,
                  height: Get.height*0.1,
                ),
              )
            ],),
            SizedBox(width: Get.width*0.04,),
            Text("Request Withdraw", style: TextStyle(fontSize: 20,fontWeight:   FontWeight.w700,color: Colors.white ))
          ],),
          SizedBox(height: Get.height*0.03,),

          Row(children: [
            SizedBox(width: Get.width*0.35,),
            Center(child: Container(child: Row(children: [
              Column(children: [
                // Image.asset(
                //   'assets/images/euro.png',
                //   // fit: BoxFit.cover, // Fixes border issues
                //   width: Get.width*0.04,
                //   height: Get.height*0.04,
                // ),
              ],),
              Column(children: [
                Text("£ 440.00",style: TextStyle(fontSize: 30,fontWeight:   FontWeight.w700,color: Color(0xff56B8F6) ))
              ],)
            ],),)),
          ],),


          SizedBox(width: Get.width*0.35,),
          Column(children: [

            Text("Your balance",style: TextStyle(fontSize: 14,fontWeight:   FontWeight.w500,color: Colors.white )),
            TextButton(
                onPressed: () {

                },
                child: GestureDetector(
                    onTap: () {
                      Get.to(()=>EditBankAccountDetail());
                    },
                    child: Text("See Account Details",style: TextStyle(fontSize: 14,fontWeight:   FontWeight.w500,color: Color(0xff56B8F6) )))

            ),
          ],),
          SizedBox(height: Get.height*0.03,),
          Container(
            height: Get.height*0.07,
            width: Get.width*0.8,
            decoration: BoxDecoration(
                color: Color.fromRGBO(69, 69, 69, 1),
                borderRadius: BorderRadius.circular(60)
            ),
            child: Row(children: [
              Container(
                width: Get.width*0.15,
                height: Get.height,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xff56B8F6),
                          Color(0xff4D6FED)
                        ],begin: Alignment.topCenter,
                        end: Alignment.bottomCenter

                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),topLeft: Radius.circular(60))),
                child:Text("£",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w500,fontSize: 26),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Container(
                  width: Get.width*0.5,
                  child: TextFormField(
                    controller: amountController,
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),

                    ),
                  ),
                ),
              ),
            ],),

          ),

          SizedBox(height: Get.height*0.03,),
          // Row(mainAxisAlignment: MainAxisAlignment.center,
          //   children: [GestureDetector(
          //     onTap: () {
          //       // Get.to(() => AddBankAccount());
          //     },
          //     child: Container(
          //       height: Get.height*0.06,
          //       width: Get.width*0.55,
          //       decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: [
          //                 Color(0xff56B8F6),
          //                 Color(0xff4D6FED)
          //               ],begin: Alignment.topCenter,
          //               end: Alignment.bottomCenter
          //
          //           ),
          //           borderRadius: BorderRadius.circular(60)
          //       ),
          //       child:  Center(
          //         child: Text('Continue',style: TextStyle(fontSize: 17,fontWeight:   FontWeight.w700,color: Colors.white )),
          //
          //       ),),
          //   )],),
          MyButton(
            width: Get.width*.66,
            title: "CONTINUE", onTap1: () {
Get.to(() =>AddBankAccountDetails());
          },)
        ],),
      ),
    );
  }
}