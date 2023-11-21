import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/CandidateJobStatusController/CandidateJobStatusController.dart';
import 'package:flikka/hiring%20Manager/schedule_interview.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ApplicantTrackingController/ApplicantTrackingController.dart';
import '../../controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../res/components/server_error_widget.dart';
import '../../res/components/unauthorised_request_widget.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class AllCandidate extends StatefulWidget {
  const AllCandidate({super.key});

  @override
  State<AllCandidate> createState() => _AllCandidateState();
}

class _AllCandidateState extends State<AllCandidate> {

  String? jobTitleValue;

  final List<String> statusList = ['Accepted','Rejected',"Pending","All"];
  String? statusValue;

  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  ApplicantTrackingDataController trackingDataController = Get.put(ApplicantTrackingDataController());
  CandidateJobStatusController statusController = Get.put(CandidateJobStatusController()) ;

@override
  void initState() {
   jobTitleController.recruiterJobTitleApi() ;
   trackingDataController.applicantTrackingApi(jobTitleValue ,statusValue ) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (trackingDataController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),);
          case Status.ERROR:
            if (trackingDataController.error.value ==
                'No internet') {
              return Scaffold(
                body: InterNetExceptionWidget(
                onPress: () {
                  jobTitleController.recruiterJobTitleApi() ;
                  trackingDataController.applicantTrackingApi(jobTitleValue ,statusValue ) ;
                },
              ),);
            } else if (trackingDataController.error.value == 'Request Time out') {
              return Scaffold(body: RequestTimeoutWidget(onPress: () {
                jobTitleController.recruiterJobTitleApi() ;
                trackingDataController.applicantTrackingApi(jobTitleValue ,statusValue ) ;
              }),);
            } else if (trackingDataController.error.value == "Internal server error") {
              return Scaffold(body: ServerErrorWidget(onPress: () {
                jobTitleController.recruiterJobTitleApi() ;
                trackingDataController.applicantTrackingApi(jobTitleValue ,statusValue ) ;
              }),);
            } else if (trackingDataController.error.value == "Unauthorised Request") {
              return Scaffold(body: UnauthorisedRequestWidget(onPress: () {
                jobTitleController.recruiterJobTitleApi() ;
                trackingDataController.applicantTrackingApi(jobTitleValue ,statusValue ) ;
              }),);
            } else {
              return Scaffold(body: GeneralExceptionWidget(onPress: () {
                jobTitleController.recruiterJobTitleApi() ;
                trackingDataController.applicantTrackingApi(jobTitleValue ,statusValue ) ;
              }),);
            }
          case Status.COMPLETED:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * .04,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * .05,
                          vertical: Get.height * .008),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldFilledColor,
                        borderRadius: BorderRadius.circular(33.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors
                              .blueThemeColor, size: 27,),
                          SizedBox(width: Get.width * .03),
                          Expanded(
                            child: TextFormField(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                  color: Color(0xffCFCFCF), fontSize: 19),
                              onChanged: (query) {
                                // filterPositionNames(query);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Color(0xffCFCFCF)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * .03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("All Candidate", style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xffFFFFFF))),
                        Row(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Select Title',
                                  style: Get.theme.textTheme.bodyLarge!
                                      .copyWith(
                                      color: AppColors.white, fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: jobTitleController.getJobTitleDetails
                                    .value.jobTitleList?.map((item) =>
                                    DropdownMenuItem(
                                      value: item.jobTitle,
                                      child: Text(item.jobTitle.toString(),
                                        style: Get.theme.textTheme.bodyLarge!
                                            .copyWith(color: AppColors.white,
                                            fontSize: 12),
                                        overflow: TextOverflow.ellipsis,),
                                      onTap: () {
                                        setState(() {
                                          jobTitleValue = item.jobTitle;
                                          trackingDataController.applicantTrackingApi(jobTitleValue, statusValue) ;
                                        });
                                      },
                                    ))
                                    .toList(),
                                value: jobTitleValue,
                                onChanged: (value) {},
                                buttonStyleData: ButtonStyleData(
                                  height: Get.height * 0.06,
                                  width: Get.width * .29,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: const Color(0xff686868))
                                    // color: Color(0xff353535),
                                  ),
                                  elevation: 2,
                                ),

                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: Get.height * 0.35,
                                  width: Get.width * .42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xff353535),
                                  ),
                                  offset: const Offset(5, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all<
                                        double>(6),
                                    thumbVisibility: MaterialStateProperty.all<
                                        bool>(true),
                                  ),
                                ),

                              ),
                            ),
                            SizedBox(width: Get.width * .02,),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Status',
                                  style: Get.theme.textTheme.bodyLarge!
                                      .copyWith(
                                      color: AppColors.white, fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: statusList.map((String item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                        style: Get.theme.textTheme.bodyLarge!
                                            .copyWith(color: AppColors.white,
                                            fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                    .toList(),
                                value: statusValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    statusValue = value;
                                    trackingDataController.applicantTrackingApi(jobTitleValue, statusValue) ;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: Get.height * 0.06,
                                  width: Get.width * .29,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: Color(0xff686868))
                                    // color: Color(0xff353535),
                                  ),
                                  elevation: 2,
                                ),

                                dropdownStyleData: DropdownStyleData(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 5),
                                  maxHeight: Get.height * 0.35,
                                  width: Get.width * 0.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xff353535),
                                  ),
                                  offset: const Offset(5, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: Radius.circular(40),
                                    thickness: MaterialStateProperty.all<
                                        double>(6),
                                    thumbVisibility: MaterialStateProperty.all<
                                        bool>(true),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: Get.height * .03,),
                    Column(
                      children: [
                        trackingDataController.applicantTrackingDataModel.value.applicantData == null ||
                            trackingDataController.applicantTrackingDataModel.value.applicantData?.length == 0 ?
                            Text("No Data" , style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xffFFFFFF))) :
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trackingDataController.applicantTrackingDataModel.value.applicantData?.length,
                            itemBuilder: (context, i) {
                              var candidateStatusData = trackingDataController.applicantTrackingDataModel.value.applicantData?[i];
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: candidateStatusData?.appliedJob?.length,
                                  itemBuilder: (context, index) {
                                    var data = candidateStatusData?.appliedJob?[index];
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                                        margin: EdgeInsets.only(bottom: Get.height *.02),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff353535),
                                            borderRadius: BorderRadius.circular(24)
                                        ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: Get.height * .013,),
                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            minVerticalPadding: 15,
                                            leading: CircleAvatar(
                                              radius: 27,
                                              // backgroundImage: NetworkImage("${data?.seekerData?.profileImg}"),
                                              child: CachedNetworkImage(
                                                imageUrl: "${data?.seekerData?.profileImg}",
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
                                            title: Text(
                                              data?.seekerData?.fullname ?? "",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                  color: const Color(0xffFFFFFF)),),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  height: Get.height * .003,),
                                                Text(candidateStatusData
                                                    ?.jobPositions ?? "",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                        color: const Color(
                                                            0xffCFCFCF),
                                                        fontWeight: FontWeight
                                                            .w600)
                                                ),
                                                SizedBox(
                                                  height: Get.height * .003,),
                                                Text(
                                                  data?.seekerData?.location ??
                                                      "", style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .labelLarge
                                                    ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(0xffCFCFCF)),),
                                                SizedBox(
                                                  height: Get.height * .003,),
                                                Text(data?.status.toString().toLowerCase() ?? "",
                                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                      fontWeight: FontWeight.w700,
                                                      color: "${data?.status}".toLowerCase() == "accepted"
                                                          ? const Color(0xff42D396) :
                                                      "${data?.status}".toLowerCase() == "rejected"
                                                          ? Colors.red : AppColors.white
                                                  ),),
                                              ],
                                            ),
                                            // trailing: const Icon(
                                            //   Icons.more_vert,
                                            //   color: Color(0xffCFCFCF),
                                            //   size: 25,),
                                          ),
                                          SizedBox(height: Get.height * .010,),
                                          "${data?.status}".toLowerCase() == "accepted" ||
                                              "${data?.status}".toLowerCase() == "rejected" ?
                                              const SizedBox() :
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              MyButton(
                                                width: Get.width * .32,
                                                height: Get.height * .066,
                                                title: "ACCEPT", onTap1: () {
                                                  CommonFunctions.showLoadingDialog(context, "updating") ;
                                                  statusController.jobStatus("Accepted", '${data?.id}',jobTitle: jobTitleValue,status: statusValue) ;
                                              },),
                                              MyButton(
                                                width: Get.width * .32,
                                                height: Get.height * .066,
                                                title: "REJECT", onTap1: () {
                                                CommonFunctions.showLoadingDialog(context, "updating") ;
                                                statusController.jobStatus("Rejected", '${data?.id}',jobTitle: jobTitleValue,status: statusValue) ;
                                              },),
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       showDialog(
                                              //         // barrierDismissible: false,
                                              //           context: context,
                                              //           builder: (
                                              //               BuildContext context) {
                                              //             return AlertDialog(
                                              //               shape: RoundedRectangleBorder(
                                              //                   borderRadius: BorderRadius
                                              //                       .circular(
                                              //                       18)),
                                              //               backgroundColor: Color(
                                              //                   0xff353535),
                                              //               contentPadding: EdgeInsets
                                              //                   .zero,
                                              //               content:
                                              //               Container(
                                              //                 alignment: Alignment
                                              //                     .center,
                                              //                 height: Get
                                              //                     .height * .5,
                                              //                 child: Column(
                                              //                   mainAxisAlignment: MainAxisAlignment
                                              //                       .center,
                                              //                   crossAxisAlignment: CrossAxisAlignment
                                              //                       .center,
                                              //                   children: [
                                              //                     SizedBox(
                                              //                       height: Get
                                              //                           .height *
                                              //                           0.001,),
                                              //                     Center(child:
                                              //                     Text(
                                              //                       "Save Notes",
                                              //                       style: Theme
                                              //                           .of(
                                              //                           context)
                                              //                           .textTheme
                                              //                           .displaySmall
                                              //                           ?.copyWith(
                                              //                           color: AppColors
                                              //                               .white,
                                              //                           fontSize: 20,
                                              //                           fontWeight: FontWeight
                                              //                               .w600),)
                                              //                     ),
                                              //                     SizedBox(
                                              //                       height: Get
                                              //                           .height *
                                              //                           .02,),
                                              //                     Center(child:
                                              //                     Text(
                                              //                       "Lorem Ipsum is simply industry.",
                                              //                       style: Theme
                                              //                           .of(
                                              //                           context)
                                              //                           .textTheme
                                              //                           .labelLarge
                                              //                           ?.copyWith(
                                              //                           fontWeight: FontWeight
                                              //                               .w400,
                                              //                           color: Color(
                                              //                               0xffCFCFCF)),)
                                              //                     ),
                                              //                     SizedBox(
                                              //                       height: Get
                                              //                           .height *
                                              //                           .03,),
                                              //                     Padding(
                                              //                       padding: EdgeInsets
                                              //                           .symmetric(
                                              //                           horizontal: Get
                                              //                               .width *
                                              //                               .04),
                                              //                       child: TextFormField(
                                              //                           maxLines: 4,
                                              //                           style: Theme
                                              //                               .of(
                                              //                               context)
                                              //                               .textTheme
                                              //                               .bodyMedium,
                                              //                           decoration: InputDecoration(
                                              //                             filled: true,
                                              //                             fillColor: const Color(
                                              //                                 0xff1A1A1A),
                                              //                             hintText: "Enter Note",
                                              //                             hintStyle: Theme
                                              //                                 .of(
                                              //                                 context)
                                              //                                 .textTheme
                                              //                                 .labelLarge
                                              //                                 ?.copyWith(
                                              //                                 color: Color(
                                              //                                     0xffCFCFCF)),
                                              //                             contentPadding: EdgeInsets
                                              //                                 .symmetric(
                                              //                                 vertical: Get
                                              //                                     .height *
                                              //                                     .03,
                                              //                                 horizontal: Get
                                              //                                     .width *
                                              //                                     .05),
                                              //                             border: OutlineInputBorder(
                                              //                                 borderRadius: BorderRadius
                                              //                                     .circular(
                                              //                                     18),
                                              //                                 borderSide: const BorderSide(
                                              //                                     color: Color(
                                              //                                         0xff1A1A1A))),
                                              //                             enabledBorder: OutlineInputBorder(
                                              //                               borderRadius: BorderRadius
                                              //                                   .circular(
                                              //                                   22),
                                              //                               // borderSide: BorderSide(color: Colors.white),
                                              //                             ),
                                              //                           )
                                              //                       ),
                                              //                     ),
                                              //                     SizedBox(
                                              //                       height: Get
                                              //                           .height *
                                              //                           0.03,),
                                              //                     MyButton(
                                              //                       width: Get
                                              //                           .width *
                                              //                           .65,
                                              //                       title: "SAVE",
                                              //                       onTap1: () {
                                              //
                                              //                       },)
                                              //                   ],),
                                              //               ),
                                              //             );
                                              //           }
                                              //       );
                                              //     },
                                              //     child: Image.asset(
                                              //       "assets/images/icon_save_request.png",
                                              //       height: Get.height * .06,)),
                                            ],
                                          ),
                                          SizedBox(height: Get.height * .027,),
                                          MyButton(
                                            height: Get.height * .066,
                                            width: Get.width*.75,
                                            title: "VIEW PROFILE", onTap1: () {
                                              Get.to( () =>  ScheduleInterview(seekerID: "${data?.seekerId}", requestID: '${data?.id}',) ) ;
                                          },),
                                          SizedBox(height: Get.height * .018,),
                                        ],
                                      ),
                                    );
                                  }
                              );
                            }
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * .08,),
                  ],
                ),
              ),
            );
        }
      }
      ),
    );
  }
}
