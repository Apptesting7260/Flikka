
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';

class RecruiterHome extends StatefulWidget {
  final RecruiterProfileDetails? recruiterProfileDetails ;
  const RecruiterHome({super.key, this.recruiterProfileDetails});

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xff000),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*.035,),
              Text("Overview",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: const Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.01,),
              Text(widget.recruiterProfileDetails?.homeDescription ?? "No Data",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
               SizedBox(height: Get.height*.03,),
              Container(
                height: Get.height*.12,
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0xff353535),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Website",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
                      SizedBox(height: Get.height*.002,),
                      Text(widget.recruiterProfileDetails?.websiteLink ?? "No Data",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: const Color(0xff56B8F6)),),

                    ],
                  ),
                ),
              ),
              // SizedBox(height: Get.height*.07,),
              // Center(child: Text("SEE ALL DETAILS",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: const Color(0xff56B8F6)),)),
              // SizedBox(height: Get.height*.1,),
            ],
          ),
        ),
      ),
    ));
  }
}
