import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/ApplyJobController/ApplyJobController.dart';
import 'package:flikka/controllers/SeekerUpdateRequestedJobStatus/SeekerUpdateRequestedJobStatus.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../utils/VideoPlayerScreen.dart';

class MarketingIntern extends StatefulWidget {
   final dynamic jobData ;
   final bool appliedJobScreen ;
   final bool? requestedJob ;
  const MarketingIntern({super.key, this.jobData, required this.appliedJobScreen, this.requestedJob});

  @override
  State<MarketingIntern> createState() => _MarketingInternState();
}

class _MarketingInternState extends State<MarketingIntern> {

  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  SeekerUpdateRequestedJobStatusController jobStatusController = Get.put(SeekerUpdateRequestedJobStatusController()) ;
  GetJobsListingController getJobsListingController = GetJobsListingController() ;
  var years ;
  var months ;
  @override
  Widget build(BuildContext context) {

    if( widget.jobData?.workExperience != null &&  widget.jobData?.workExperience.toString().length != 0) {
      var experience = widget.jobData?.workExperience.toString().split(".");
      if(experience?.length == 2) {
       if( experience?[0] != null && experience?[0].length != 0 && experience?[0].toString() != "0") {
          years = "${experience?[0]} year";
        }
       if( experience?[1] != null && experience?[1].length != 0 && experience?[1].toString() != "00") {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      Row(
                        children: [
                          SizedBox(width: Get.width*.04,) ,
                          widget.jobData?.video == null ||
                              widget.jobData?.video?.length == 0 ?
                          const SizedBox() :
                          GestureDetector(
                            onTap: () {
                              Get.back() ;
                              Get.to(() => VideoPlayerScreen(videoPath: widget.jobData?.video ?? "")) ;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 42,
                              width: 42,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.blueThemeColor
                              ),
                              child: Image.asset(
                                "assets/images/icon_video.png",
                                height: 18,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Text(
                    "${widget.jobData?.jobTitle ?? "No job title"}", overflow: TextOverflow.ellipsis,
                    style:  Get.theme.textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Text(
                    "${widget.jobData?.jobPositions ?? "No job position"}",overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Text(
                    "${widget.jobData?.recruiterDetails?.companyName ?? "No company name"}", overflow: TextOverflow.ellipsis,
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
                  HtmlWidget(widget.jobData?.description ?? 'No job description',textStyle:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)) ,),
                  SizedBox(height: Get.height * 0.03,),
                  Text("Requirements", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  HtmlWidget(widget.jobData?.requirements ?? 'No requirements',textStyle: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height * 0.025,),
                  Text("Locations", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.jobLocation ?? "No job location",overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height * 0.015,),
                  InkWell(
                      // onTap: ()=>Get.to(const GoogleMapIntegration()),
                      child: SizedBox( height: Get.height * 0.3,
                          child: GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${widget.jobData?.lat}"),long:  double.tryParse("${widget.jobData?.long}"),))),
                  SizedBox(height: Get.height * 0.035,),
                  Text("Information", style:Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  Text("Position", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    widget.jobData?.jobPositions ?? "No position",
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
                  widget.jobData?.education.toString().toLowerCase() == "null" ||
                      widget.jobData?.education.toString().length == 0
                      ? Text("No qualification", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  Text(
                    widget.jobData?.education ?? "",
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
                  Text("${years ?? ""} ${ months ?? "No experience"}",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  const Text("Job Type", style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.employmentType ?? "No job type",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  const Divider(color: Colors.grey, thickness: 0.2,),
                  const Text("Specialization", style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.specialization ?? "No specialization",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  const Divider(color: Colors.grey, thickness: 0.2,),
                  const Text("Type of workplace",
                    style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.typeOfWorkplace ?? "No workplace",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  const Divider(color: Colors.grey, thickness: 0.2,),
                  const Text(
                    "Preferred work experience",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    widget.jobData?.preferredWorkExperience ?? "No preferred work experience",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  const Text(
                    "Language",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  widget.jobData?.languageName == null || widget.jobData?.languageName?.length == 0 ?
                       Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.jobData?.languageName?.length,
                    itemBuilder: (context , index) {
                      var data = widget.jobData?.languageName?[index] ;
                      return Text(data?.languages ?? "",
                        style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                      );
                    }
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  Text(
                    "Soft Skills",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  /////
                  widget.jobData?.jobsDetail?.skillName == null ||
                      widget.jobData?.jobsDetail?.skillName?.length == 0 ?
                   Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount:widget.jobData?.jobsDetail?.skillName?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff484848),
                          ),
                          child: Text(widget.jobData?.jobsDetail?.skillName?[index].skills ?? "",
                            overflow: TextOverflow
                                .ellipsis,
                            style: Get.theme.textTheme
                                .bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight
                                    .w400,fontSize: 9),),
                        );
                      }),
                  ///
                  SizedBox(height: Get.height*0.04,),
                  Text(
                    "Passion",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  widget.jobData?.jobsDetail?.passionName == null ||
                      widget.jobData?.jobsDetail?.passionName?.length == 0 ?
                    Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.passionName?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(20),
                            color: const Color(0xff484848),
                          ),
                          // padding: const EdgeInsets.all(
                          //     8),
                          child: Text( widget.jobData?.jobsDetail?.passionName?[index].passion  ?? '',
                            overflow: TextOverflow
                                .ellipsis,
                            style: Get.theme.textTheme
                                .bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight
                                    .w400,fontSize: 9),),
                        );
                      }),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Text(
                    "industry preference",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  widget.jobData?.jobsDetail?.industryPreferenceName == null ||
                      widget.jobData?.jobsDetail?.industryPreferenceName?.length == 0 ?
                    Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.industryPreferenceName?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(20),
                            color: Color(0xff484848),
                          ),
                          // padding: const EdgeInsets.all(
                          //     8),
                          child: Text(widget.jobData?.jobsDetail?.industryPreferenceName?[index].industryPreferences ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,fontSize: 9),),
                        );
                      }),
                  SizedBox(height: Get.height * 0.04,),
                  Text("Strengths",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  widget.jobData?.jobsDetail?.strengthsName == null ||
                      widget.jobData?.jobsDetail?.strengthsName?.length == 0 ?
                  Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.strengthsName?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(20),
                            color: const Color(0xff484848),
                          ),
                          // padding: const EdgeInsets.all(
                          //     8),
                          child: Text( widget.jobData?.jobsDetail?.strengthsName?[index].strengths ?? '',
                            overflow: TextOverflow
                                .ellipsis,
                            style: Get.theme.textTheme
                                .bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight
                                    .w400,fontSize: 9),),
                        );
                      }),
                  SizedBox(height: Get.height * 0.04,),
                  Text(
                    "Salary expectation",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius
                          .circular(20),
                      color: const Color(0xff484848),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal : 20 ,vertical: 12),
                    child: Text('${widget.jobData?.jobsDetail?.minSalaryExpectation ?? ''}   ${widget.jobData?.jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'}',
                      style: Get.theme.textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400),),
                  ),
                  SizedBox(height: Get.height * 0.04,),
                  Text(
                    "When can i start working?",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  widget.jobData?.jobsDetail?.startWorkName == null ||
                      widget.jobData?.jobsDetail?.startWorkName?.length == 0 ?
                  Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.startWorkName?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(20),
                            color: Color(0xff484848),
                          ),
                          // padding: const EdgeInsets.all(
                          //     8),
                          child: Text( widget.jobData?.jobsDetail?.startWorkName?[index].startWork ?? '',
                            overflow: TextOverflow
                                .ellipsis,
                            style: Get.theme.textTheme
                                .bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight
                                    .w400,fontSize: 9),),
                        );
                      }),

                  SizedBox(height: Get.height * 0.04,),
                  Text(
                    "Availability",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.white),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  widget.jobData?.jobsDetail?.availabityName == null ||
                      widget.jobData?.jobsDetail?.availabityName?.length == 0 ?
                  Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount:  widget.jobData?.jobsDetail?.availabityName?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(20),
                            color: const Color(0xff484848),
                          ),
                          // padding: const EdgeInsets.all(
                          //     8),
                          child: Text(  widget.jobData?.jobsDetail?.availabityName?[index].availabity ?? '',
                            overflow: TextOverflow
                                .ellipsis,
                            style: Get.theme.textTheme
                                .bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight
                                    .w400,fontSize: 9),),
                        );
                      }),
                  SizedBox(
                    height: Get.height * 0.055,
                  ),
                  widget.appliedJobScreen ? const SizedBox() :
                      widget.requestedJob == true ?
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(title:   "ACCEPT",
                              width: Get.width *.4,
                              onTap1: () {
                                  CommonFunctions.showLoadingDialog(context, "Updating...") ;
                                 jobStatusController.updateStatus("${widget.jobData?.id}", "Accept",context) ;
                              }),
                          MyButton(title: "REJECT",
                              width: Get.width *.4,
                              onTap1: () {
                                CommonFunctions.showLoadingDialog(context, "Updating...") ;
                                jobStatusController.updateStatus("${widget.jobData?.id}", "Reject",context) ;
                              }),
                        ],)
                 : widget.jobData?.postApplied == true ? const SizedBox() :
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
