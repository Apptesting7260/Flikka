import 'package:flikka/controllers/VerifyOtpController/VerifyOtpController.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:get/get.dart';
import '../../widgets/app_colors.dart';

class OtpScreen extends StatefulWidget {
  final bool register ;
  const OtpScreen({Key? key, required this.register}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  VerifyOtpController VerifyOtpControllerInstanse=Get.put(VerifyOtpController());
  final focusNode = FocusNode();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;


  var email = Get.arguments["email"] ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueAccent,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(color: AppColors.blueThemeColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.08,),
                    Center(
                      child: Text("Verification",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30,color: Color(0XFFFFFFFF))),
                    ),
                    SizedBox(height: Get.height*.015,),
                    SizedBox(
                      width: Get.width*.85,
                      child: Center(
                        child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffFFFFFF),fontSize: 13),),
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.72, // half screen
                minChildSize: 0.72, // half screen
                maxChildSize: 1, // full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                    // color: Colors.black,
                    child:   SingleChildScrollView(
                      controller:scrollController ,
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(33.0),
                            topRight: Radius.circular(33.0),
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: Get.width*.03),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: Get.height*.05,),
                               Center(child: Text("Enter Verification Code",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600,color: Color(0xffFFFFFF)),)),
                               SizedBox(height: Get.height*.015,),
                               Row( mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Directionality(
                                       textDirection: TextDirection.ltr,
                                       child: Flexible(
                                         child: Pinput(
                                           length: 6,
                                           controller: VerifyOtpControllerInstanse.otpController.value,
                                           focusNode: focusNode,
                                           androidSmsAutofillMethod:
                                           AndroidSmsAutofillMethod.smsUserConsentApi,
                                           listenForMultipleSmsOnAndroid: true,

                                           validator: (value) {
                                             if (value!.isEmpty){
                                               return 'Please enter the otp';
                                             }
                                             return null;
                                           },
                                           hapticFeedbackType: HapticFeedbackType.lightImpact,
                                           onCompleted: (pin) {
                                             debugPrint('onCompleted: $pin');
                                           },
                                           onChanged: (value) {
                                             debugPrint('onChanged: $value');
                                           },
                                           cursor: Column(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                             children: [
                                               Container(
                                                 margin: const EdgeInsets.only(bottom: 9),
                                                 width: 20,
                                                 height: 2,
                                                 color: const Color.fromRGBO(23, 171, 144, 1),
                                               ),
                                             ],
                                           ),
                                           defaultPinTheme: PinTheme(
                                             width: Get.width*0.15,
                                             height: Get.height*0.08,
                                             textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),
                                             decoration: const BoxDecoration(
                                               color: Color(0xff353535),
                                               shape: BoxShape.circle,
                                             ),
                                           ),
                                         ),
                                       )),
                                 ],
                               ),
                               Obx(() => VerifyOtpControllerInstanse.verifyOtpErrorMessage.value.isEmpty ?
                               const SizedBox() :
                               Text(VerifyOtpControllerInstanse.verifyOtpErrorMessage.value,style: TextStyle(color: Colors.red),)
                               ),
                               SizedBox(height: Get.height*.065,),
                            Obx(() => Center(
                              child: MyButton(
                                loading: VerifyOtpControllerInstanse.loading.value,
                                title: "VERIFY", onTap1: () {
                                  VerifyOtpControllerInstanse.verifyOtpErrorMessage.value = "" ;
                                if(_formKey.currentState!.validate()){
                                  _formKey.currentState!.save();
                                  VerifyOtpControllerInstanse.verifyOtpApiHit(email , widget.register);
                                }
                              },),
                            )),
                             ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

      ),
    );
  }
}


