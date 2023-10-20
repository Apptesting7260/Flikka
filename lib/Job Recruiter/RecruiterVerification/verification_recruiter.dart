import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationRecruiter extends StatefulWidget {
  const VerificationRecruiter({super.key});

  @override
  State<VerificationRecruiter> createState() => _VerificationRecruiterState();
}

class _VerificationRecruiterState extends State<VerificationRecruiter> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
            child: Column(
              children: [
                SizedBox(height: Get.height*.03,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                        child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,)),
                    SizedBox(width: Get.width*.045,),
                    Text("verification",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),)
                  ],
                ),
                SizedBox(height: Get.height*.029,),
                Text("Recruiter and Company Verification",style: Theme.of(context).textTheme.displayLarge,),
                SizedBox(height: Get.height*.01,),
                Text("Choose one of the following verification method:",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))),
                SizedBox(height: Get.height*.035,),
                Container(
                  height: Get.height*.38,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(0xff353535),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height*.029,),
                        Text("Verify with your Work Email",style: Theme.of(context).textTheme.labelMedium,),
                        SizedBox(height: Get.height*.02,),
                        Text("You may be verified faster if you use your work email address associated with your company's website domain.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                        SizedBox(height: Get.height*.02,),
                        Text("Note: Please check the email domain and website domain matches with the company's official name. If the names do not match, it might not pass the verification process.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                        SizedBox(height: Get.height*.04,),
                        MyButton(
                          width: Get.width*.35,
                          height: Get.height*.056,
                          title: "CHOOSE", onTap1: () {

                        },)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.03,),
                Text("Or",style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(height: Get.height*.03,),
                Container(
                  height: Get.height*.38,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(0xff353535),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height*.029,),
                        Text("Verify with your Work Email",style: Theme.of(context).textTheme.labelMedium,),
                        SizedBox(height: Get.height*.02,),
                        Text("You may be verified faster if you use your work email address associated with your company's website domain.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                        SizedBox(height: Get.height*.02,),
                        Text("Note: Please check the email domain and website domain matches with the company's official name. If the names do not match, it might not pass the verification process.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                        SizedBox(height: Get.height*.04,),
                        MyButton(
                          width: Get.width*.35,
                          height: Get.height*.056,
                          title: "CHOOSE", onTap1: () {

                        },)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.1,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
