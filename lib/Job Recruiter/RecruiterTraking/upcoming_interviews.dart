import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/ScheduledInterviewListController/ScheduledInterviewListController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../res/components/server_error_widget.dart';
import '../../widgets/app_colors.dart';

class UpcomingInterviews extends StatefulWidget {
  const UpcomingInterviews({super.key});

  @override
  State<UpcomingInterviews> createState() => _UpcomingInterviewsState();
}

class _UpcomingInterviewsState extends State<UpcomingInterviews> {
  final List<String> jobTypeItems = ['Upcoming','Rejected','Selected',];
  String? jobTypeValues;

  ScheduledInterviewListController interviewListController = Get.put(ScheduledInterviewListController()) ;

  @override
  void initState() {
   interviewListController.interviewListApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (interviewListController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (interviewListController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  interviewListController.interviewListApi();
                },
              ),);
          } else
          if (interviewListController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              interviewListController.interviewListApi();
            }),);
          } else
          if (interviewListController.error.value == "Internal server error") {
            return Scaffold(body: ServerErrorWidget(onPress: () {
              interviewListController.interviewListApi();
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              interviewListController.interviewListApi();
            }),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Upcoming Interviews", style: Theme
                      //         .of(context)
                      //         .textTheme
                      //         .bodyLarge
                      //         ?.copyWith(fontWeight: FontWeight.w700,
                      //         color: Color(0xffFFFFFF))),
                      //     DropdownButtonHideUnderline(
                      //       child: DropdownButton2<String>(
                      //         isExpanded: true,
                      //         hint: Row(
                      //           children: [
                      //             const SizedBox(width: 4,),
                      //             Expanded(
                      //               child: Text(
                      //                 'Upcoming',
                      //                 style: Get.theme.textTheme.bodyLarge!
                      //                     .copyWith(color: AppColors.white),
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         items: jobTypeItems.map((String item) =>
                      //             DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(
                      //                 item,
                      //                 style: Get.theme.textTheme.bodyLarge!
                      //                     .copyWith(color: AppColors.white),
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ))
                      //             .toList(),
                      //         value: jobTypeValues,
                      //         onChanged: (String? value) {
                      //           setState(() {
                      //             jobTypeValues = value;
                      //           });
                      //         },
                      //         buttonStyleData: ButtonStyleData(
                      //           height: Get.height * 0.060,
                      //           width: Get.width * .26,
                      //           padding: const EdgeInsets.only(
                      //               left: 14, right: 14),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(35),
                      //               border: Border.all(color: Color(0xff686868))
                      //             // color: Color(0xff353535),
                      //           ),
                      //           elevation: 2,
                      //         ),
                      //         iconStyleData: IconStyleData(
                      //           icon: Image.asset(
                      //               'assets/images/arrowdown.png'),
                      //           iconSize: 14,
                      //           iconEnabledColor: Colors.yellow,
                      //           iconDisabledColor: Colors.grey,
                      //         ),
                      //         dropdownStyleData: DropdownStyleData(
                      //           maxHeight: Get.height * 0.35,
                      //           width: Get.width * 0.902,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(14),
                      //             color: Color(0xff353535),
                      //           ),
                      //           offset: const Offset(5, 0),
                      //           scrollbarTheme: ScrollbarThemeData(
                      //             radius: Radius.circular(40),
                      //             thickness: MaterialStateProperty.all<double>(
                      //                 6),
                      //             thumbVisibility: MaterialStateProperty.all<
                      //                 bool>(true),
                      //           ),
                      //         ),
                      //         menuItemStyleData: const MenuItemStyleData(
                      //           height: 40,
                      //           padding: EdgeInsets.only(left: 14, right: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: Get.height * .01,),

                      interviewListController.interviewData.value.seeker == null ||
                          interviewListController.interviewData.value.seeker?.length == 0 ?
                          Text("No Data", style: Theme.of(context).textTheme.bodyLarge?.
                          copyWith(fontWeight: FontWeight.w700, color: const Color(0xffFFFFFF))) :
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: interviewListController.interviewData.value.seeker?.length,
                        itemBuilder: (context, index) {
                          var data = interviewListController.interviewData.value.seeker?[index] ;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: Get.height * .027),
                            child: Container(
                              height: Get.height * .45,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: const Color(0xff353535)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .06),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height * .013,),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      minVerticalPadding: 12,
                                      leading: CircleAvatar(
                                        radius: 28,
                                        backgroundImage: NetworkImage( data?.seekerData?.profileImg ?? "",),
                                      ),
                                      title: Text( data?.seekerData?.fullname ?? "", style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                          color: const Color(0xffFFFFFF)),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text( data?.details?.jobTitle ?? "",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                  color: const Color(0xffCFCFCF),
                                                  fontWeight: FontWeight.w600)
                                          ),
                                          SizedBox(height: Get.height * .003,),
                                          Text( data?.seekerData?.location ?? "", style: Theme
                                              .of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffCFCFCF)),),
                                        ],
                                      ),
                                      // trailing: Image.asset(
                                      //   "assets/images/Edit.png",
                                      //   height: Get.height * .028,),
                                    ),
                                    SizedBox(height: Get.height * .025,),
                                    Text( CommonFunctions.parseHTML(data?.seekerData?.aboutMe ?? ""), style: Theme.of(context).textTheme
                                          .bodyLarge?.copyWith(fontWeight: FontWeight.w400,
                                          color: const Color(0xffCFCFCF)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: Get.height * .03,),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/icon_calendar.png",
                                          height: Get.height * .026,
                                          color: Color(0xff56B8F6),),
                                        SizedBox(width: Get.width * .02,),
                                        Text("${data?.interviewScheduleTime?.year}-${data?.interviewScheduleTime?.month}-${data?.interviewScheduleTime?.day}", style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffFFFFFF)),),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * .02,),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/icon_watch.png",
                                          height: Get.height * .026,
                                          color: const Color(0xff56B8F6),),
                                        SizedBox(width: Get.width * .02,),
                                        Text("${data?.interviewScheduleTime?.hour}:${data?.interviewScheduleTime?.minute}", style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffCFCFCF)),),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * .031,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        MyButton(
                                          height: Get.height * .066,
                                          width: Get.width * .38,
                                          title: "JOIN", onTap1: () {

                                        },),
                                        SizedBox(
                                          height: Get.height * .066,
                                          width: Get.width * 0.38,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              padding: EdgeInsets.all(
                                                  0), // Set padding to 0 to allow gradient to cover the entire button
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                                "CANCEL",
                                                style: Get.theme.textTheme
                                                    .bodyLarge!.copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold)
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: Get.height * .031,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },),
                      SizedBox(height: Get.height * .1,),
                    ],
                  ),
                ),
              ),
            ),
          );
      }
    }
    );
  }
}
