import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/ApplyJobController/ApplyJobController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/GetJobsListingController/GetJobsListingController.dart';

class MarketingIntern extends StatefulWidget {
   final dynamic jobData ;
   final bool appliedJobScreen ;
  const MarketingIntern({super.key, this.jobData, required this.appliedJobScreen});

  @override
  State<MarketingIntern> createState() => _MarketingInternState();
}

class _MarketingInternState extends State<MarketingIntern> {

  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  GetJobsListingController getJobsListingController = GetJobsListingController() ;
  var years ;
  var months ;
  @override
  Widget build(BuildContext context) {

    if( widget.jobData?.workExperience != null &&  widget.jobData?.workExperience.toString().length != 0) {
      var experience = widget.jobData?.workExperience.toString().split(".");
      if(experience?.length == 2) {
       if( experience?[0] != null && experience?[0].length != 0) {
          years = "${experience?[0]} year";
        }
       if( experience?[1] != null && experience?[1].length != 0) {
          months = "${experience?[1]} month";
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/icon_back_blue.png',scale: 4,)),
          elevation: 0,
          title: Text("${widget.jobData?.jobPositions ?? " Title"}",overflow: TextOverflow.ellipsis,style: Get.theme.textTheme.displayLarge),

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff353535),
                borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 12),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      radius: 45,
                      // backgroundImage: NetworkImage('${widget.jobData?.featureImg}'),
                      child: CachedNetworkImage(
                        imageUrl: '${widget.jobData?.featureImg}',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Text(
                    "${widget.jobData?.jobTitle}",
                    style:  Get.theme.textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Text(
                    "${widget.jobData?.jobPositions}",overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Text(
                    "${widget.jobData?.recruiterDetails?.companyName}",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    "Job Description",
                    style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  HtmlWidget(widget.jobData?.description ?? '',textStyle:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)) ,),
                  // Text(
                  //  CommonFunctions.parseHTML( widget.jobData?.description ?? '' ) ?? '',
                  //   style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  // ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text("Requirements", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  HtmlWidget(widget.jobData?.requirements ?? '',textStyle: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  // Text(CommonFunctions.parseHTML( widget.jobData?.requirements ?? '' ) ?? '',
                  //   style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height * 0.025,),
                  Text("Locations", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  Text("${widget.jobData?.jobLocation}",overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height * 0.015,),
                  InkWell(
                      onTap: ()=>Get.to(const GoogleMapIntegration()),
                      child: Image.asset('assets/images/Map.png')),
                  SizedBox(height: Get.height * 0.035,),
                  Text("Informations", style:Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  Text("Position", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "${widget.jobData?.jobPositions}",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),

                  const Text(
                    "Qualification",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "${widget.jobData?.education}",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),

                  const Text(
                    "Experience",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  years != null || months != null ?
                  Text("${years ?? ""} ${ months ?? ""}",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ): Text("No Data", style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),

                  const Text(
                    "Job Type",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "${widget.jobData?.employmentType}",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),

                  const Text(
                    "Specialization",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "${widget.jobData?.specialization}",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  const Text(
                    "Type of workplace",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "${widget.jobData?.typeOfWorkplace}",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  const Text(
                    "Preferred work experience",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "${widget.jobData?.preferredWorkExperience}",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  // const Text(
                  //   "Language",
                  //   style: TextStyle(color: Colors.white, fontSize: 14),
                  // ),
                  // SizedBox(
                  //   height: Get.height * 0.015,
                  // ),
                  // widget.jobData?.languages == null || widget.jobData?.languages?.length == 0 ?
                  //     const SizedBox() :
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: widget.jobData?.languages?.length,
                  //   itemBuilder: (context , index) {
                  //     var data = widget.jobData?.languages?[index] ;
                  //     return Text(data?.languages ?? "",
                  //       style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  //     );
                  //   }
                  // ),
                  // const Divider(
                  //   color: Colors.grey,
                  //   thickness: 0.2,
                  // ),
                  SizedBox(
                    height: Get.height * 0.055,
                  ),
                  widget.appliedJobScreen ? const SizedBox() :
                  Obx( () => MyButton(
                      loading: applyJobController.loading.value,
                      title: "APPLY NOW",
                      onTap1: () {
                    applyJobController.applyJob("${widget.jobData?.id}") ;
                    },),
                  ),
                  SizedBox(height: Get.height*.1,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
