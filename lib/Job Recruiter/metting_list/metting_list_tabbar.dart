
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Job Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import '../../controllers/SeekerViewInterviewAllController/SeekerViewInterviewAllController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';
import 'past.dart';
import 'upcoming.dart';

class MettingListTabbar extends StatefulWidget {
  const MettingListTabbar({super.key});

  @override
  State<MettingListTabbar> createState() => _MettingListTabbarState();
}
SeekerViewInterviewAllController interviewListController = Get.put(SeekerViewInterviewAllController()) ;

class _MettingListTabbarState extends State<MettingListTabbar> {

  final List<String> jobTypeItems = ['Upcoming','Past','All',];
  String? jobTypeValues;

  @override
  void initState() {
    interviewListController.seekerInterViewListApi();
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
                  interviewListController.seekerInterViewListApi();
                },
              ),);
          } else
          if (interviewListController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              interviewListController.seekerInterViewListApi();
            }),);
          }  else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              interviewListController.seekerInterViewListApi();
            }),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                toolbarHeight: 75,
                leading: IconButton(
                    onPressed: () { Get.offAll(const TabScreen(index: 0)) ;}, icon:
                Image.asset("assets/images/icon_back_blue.png",
                  height: Get.height * .06,)) ,
                title:Text("Interviews", style: Get.theme.textTheme
                    .displayLarge),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Interviews", style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w700,
                              color: Color(0xffFFFFFF))),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  const SizedBox(width: 4,),
                                  Expanded(
                                    child: Text(
                                      'Filter',
                                      style: Get.theme.textTheme.bodyLarge!
                                          .copyWith(color: AppColors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: jobTypeItems.map((String item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: Get.theme.textTheme.bodyLarge!
                                          .copyWith(color: AppColors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )).toList(),
                              value: jobTypeValues,
                              onChanged: (String? value) {
                                setState(() {
                                  jobTypeValues = value;
                                  interviewListController.seekerInterViewListApi();
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: Get.height * 0.060,
                                width: Get.width * .26,
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(color: Color(0xff686868))
                                  // color: Color(0xff353535),
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: IconStyleData(
                                icon: Image.asset('assets/images/arrowdown.png'),
                                iconSize: 14,
                                iconEnabledColor: Colors.yellow,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: Get.height * 0.35,
                                width: Get.width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color(0xff353535),
                                ),
                                offset: const Offset(5, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(
                                      6),
                                  thumbVisibility: MaterialStateProperty.all<
                                      bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * .01,),

                      interviewListController.seekerInterViewData.value.interviewSchedule == null ||
                          interviewListController.seekerInterViewData.value.interviewSchedule?.length == 0 ?
                      Text("No Data", style: Theme.of(context).textTheme.bodyLarge?.
                      copyWith(fontWeight: FontWeight.w700, color: const Color(0xffFFFFFF))) :
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: interviewListController.seekerInterViewData.value.interviewSchedule?.length,
                        itemBuilder: (context, index) {
                          var data = interviewListController.seekerInterViewData.value.interviewSchedule?[index] ;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: Get.height * .027),
                            child: Container(
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
                                              color: const Color(0xffCFCFCF)),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Get.height * .025,),
                                    HtmlWidget(data?.seekerData?.aboutMe ?? "",textStyle: Theme.of(context).textTheme
                                        .bodyLarge?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffCFCFCF)),),
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
                                        Text("${data?.interviewScheduleTime?.hour.toString().padLeft(2,"0")} : ${data?.interviewScheduleTime?.minute.toString().padLeft(2,"0")}", style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffCFCFCF)),),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * .03,),
                                    data?.interviewLink == null || data?.interviewLink?.length == 0 ?
                                    const SizedBox() :
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse("${data?.interviewLink}"),
                                            mode: LaunchMode.externalApplication) ;
                                      },
                                      child: Text(data?.interviewLink ?? "No Data",style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blueThemeColor)),
                                    ) ,
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
