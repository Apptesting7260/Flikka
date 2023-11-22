import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import '../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../widgets/app_colors.dart';

class ViewRecruiterJob extends StatefulWidget {
  final RecruiterJobsData? recruiterJobsData ;
  final String? company ;
  const ViewRecruiterJob({super.key, required this.recruiterJobsData, this.company});

  @override
  State<ViewRecruiterJob> createState() => _ViewRecruiterJobState();
}

class _ViewRecruiterJobState extends State<ViewRecruiterJob> {
  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  bool selectedFav = false;
  Color buttonColor = AppColors.ratingcommenttextcolor;

  void toggleFavorite() {
    setState(() {
      selectedFav = !selectedFav;
      buttonColor = selectedFav ? AppColors.red : AppColors.ratingcommenttextcolor;
    });
  }

  TextEditingController commentController = TextEditingController();
  ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());

  @override
  Widget build(BuildContext context) {
    print(widget.recruiterJobsData?.description) ;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                  onTap: () { Get.back(); },
                  child: Image.asset('assets/images/icon_back_blue.png')),
            ),
            elevation: 0,
            title: Text(widget.company ?? "",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*.024,vertical: Get.height *.01),
            child: Stack(
              children: [
                //*************** for swiper image **************
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28)
                  ),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: '${widget.recruiterJobsData?.featureImg}',
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator()),
                      fit: BoxFit.cover,
                      height: Get.height *0.45,
                    ),
                  ),
                ),
                //*************** for marketing intern **************

                DraggableScrollableSheet(
                  initialChildSize: 0.55, // half screen
                  minChildSize: 0.55, // half screen
                  maxChildSize: 1, // full screen
                  builder: (BuildContext context, ScrollController scrollController) {
                    return  ListView(
                      controller: scrollController,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: AppColors.blackdown,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                            ),

                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03,vertical: Get.height*.05),
                              child: Column(
                                children: [
                                  //********************* for jessica  ***************************
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.blackdown,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text( widget.recruiterJobsData?.jobPositions ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          softWrap: true,
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.company ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: const Color(0xffCFCFCF)),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("Job Description",
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                        SizedBox(height: Get.height * 0.010,),
                                        HtmlWidget(widget.recruiterJobsData?.description ?? "",
                                        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                color:  const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) ,
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Requirements",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.015,),
                                        HtmlWidget(widget.recruiterJobsData?.requirements ?? "",textStyle: Theme.of(context).textTheme
                                            .bodySmall!.copyWith(color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) ,
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Job type",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.employmentType ??"",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Type of workplace",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.typeOfWorkplace ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Work experience",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.workExperience ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Education",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.education ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text("Language",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        widget.recruiterJobsData?.language == null || widget.recruiterJobsData?.language?.length == 0 ?
                                            const SizedBox() :
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget.recruiterJobsData?.language?.length,
                                          itemBuilder: (context , index) {
                                            return Text(  widget.recruiterJobsData?.language?[index].languages ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                            );
                                          }
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
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
                                        widget.recruiterJobsData?.jobsDetail?.skillName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.skillName?.length == 0 ?
                                            const SizedBox() :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.skillName?.length,
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
                                                child: Text(widget.recruiterJobsData?.jobsDetail?.skillName?[index].skills ?? "",
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
                                        widget.recruiterJobsData?.jobsDetail?.passionName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.passionName?.length == 0 ?
                                            const SizedBox() :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.passionName?.length,
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
                                                child: Text( widget.recruiterJobsData?.jobsDetail?.passionName?[index].passion  ?? '',
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
                                        widget.recruiterJobsData?.jobsDetail?.industryPreferenceName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?.length == 0 ?
                                            const SizedBox() :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?.length,
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
                                                child: Text(widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?[index].industryPreferences ?? "",
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
                                        widget.recruiterJobsData?.jobsDetail?.strengthsName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.strengthsName?.length == 0 ?
                                            const SizedBox() :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.strengthsName?.length,
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
                                                child: Text( widget.recruiterJobsData?.jobsDetail?.strengthsName?[index].strengths ?? '',
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
                                          child: Text('${widget.recruiterJobsData?.jobsDetail?.minSalaryExpectation ?? ''} - ${widget.recruiterJobsData?.jobsDetail?.maxSalaryExpectation ?? ''}',
                                            overflow: TextOverflow.ellipsis,
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
                                        widget.recruiterJobsData?.jobsDetail?.startWorkName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.startWorkName?.length == 0 ?
                                            const SizedBox() :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.startWorkName?.length,
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
                                                child: Text( widget.recruiterJobsData?.jobsDetail?.startWorkName?[index].startWork ?? '',
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
                                        widget.recruiterJobsData?.jobsDetail?.availabityName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.availabityName?.length == 0 ?
                                            const SizedBox() :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount:  widget.recruiterJobsData?.jobsDetail?.availabityName?.length,
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
                                                child: Text(  widget.recruiterJobsData?.jobsDetail?.availabityName?[index].availabity ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),
                                        SizedBox(height: Get.height*0.02,),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),

                      ],
                    );

                  },
                ),

              ],
            ),
          )
      ),
    );
  }
}
