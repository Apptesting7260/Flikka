import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/models/RecruiterHomePageModel/RecruiterHomePageModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/VideoPlayerScreen.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';


class ViewCandidateProfile extends StatefulWidget {
  final RecruiterHomePageSeekerDetail? recruiterData;
  const ViewCandidateProfile({Key? key, this.recruiterData}) : super(key: key);

  @override
  State<ViewCandidateProfile> createState() => _ViewCandidateProfileState();
}

class _ViewCandidateProfileState extends State<ViewCandidateProfile> {
  ViewSeekerProfileController seekerProfileController =
      Get.put(ViewSeekerProfileController());

  String uri = '';
  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueThemeColor,
        toolbarHeight: 75,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset('assets/images/backiconsvg.svg')),
        ),
        elevation: 0,
        title: Text(widget.recruiterData?.seeker?.fullname ?? "",
              style: Get.theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.blueThemeColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Stack(children: [
                      CircleAvatar(
                        radius: 40,
                        child: CachedNetworkImage(
                          imageUrl: widget.recruiterData?.seeker?.profileImg ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ])
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                HtmlWidget(widget.recruiterData?.seeker?.fullname ?? "",
                    textStyle: Get.theme.textTheme.displayLarge),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Text(widget.recruiterData?.positions ?? "",
                    style: Get.theme.textTheme.bodyLarge!
                        .copyWith(color: AppColors.white)),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                HtmlWidget(widget.recruiterData?.seeker?.location ?? "",
                    textStyle: Get.theme.textTheme.bodyLarge!
                        .copyWith(color: AppColors.white)),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.white),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    'assets/images/icon_msg.png')),
                          ],
                        )),
                    SizedBox(
                      width: Get.width * 0.045,
                    ),
                    widget.recruiterData?.seeker?.mobile == null ||
                        widget.recruiterData?.seeker?.mobile.toString().length == 0
                        ? const SizedBox()
                        : Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // if (kDebugMode) {
                                //   print("tapped") ;
                                // }
                                // CommonFunctions.launchDialer("${widget.recruiterData?.seeker?.mobile}") ;
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.white),
                                  child: IconButton(
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print("tapped") ;
                                        }
                                        CommonFunctions.launchDialer("${widget.recruiterData?.seeker?.mobile}") ;
                                      },
                                      icon: Image.asset(
                                        'assets/images/icon_call.png',
                                        scale: 0.7,
                                      ))),
                            ),
                            SizedBox(
                              width: Get.width * 0.045,
                            ),
                          ],
                        ),
                    widget.recruiterData?.seeker?.shortVideo == null ||
                        widget.recruiterData?.seeker?.shortVideo.toString().length == 0
                        ? const SizedBox()
                   : GestureDetector(
                      onTap: () {
                        Get.to(() => VideoPlayerScreen(videoPath: widget.recruiterData?.seeker?.shortVideo ?? "")) ;
                      },
                     child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white
                        ),
                        child: Image.asset(
                          "assets/images/icon_video.png",color: AppColors.blueThemeColor,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                   ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                widget.recruiterData?.startWorkName == null ||
                    widget.recruiterData?.startWorkName?.length == 0 ? const SizedBox()
                    : SizedBox(
                        height: Get.height * 0.072,
                        width: Get.width * 0.69,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          onPressed: () {},
                          child: Text(
                            widget.recruiterData?.startWorkName?[0].startWork ??
                                "",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
        //************* scrollable functionality ******************
        DraggableScrollableSheet(
          initialChildSize:  widget.recruiterData?.startWorkName == null || widget.recruiterData?.startWorkName?.length == 0 ? 0.48 : 0.42, // half screen
          minChildSize: widget.recruiterData?.startWorkName == null || widget.recruiterData?.startWorkName?.length == 0 ? 0.48 : 0.42,// half screen
          maxChildSize: 1, // full screen
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/icon_phone_call.png",height: Get.height*.03,),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text("Phone Number",style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ) ,
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          Text(widget.recruiterData?.seeker?.mobile ?? "No Data") ,
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Image.asset(
                                'assets/images/about.png',
                                height: Get.height * .03,
                              )),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text(
                                "About",
                                style: Theme.of(context).textTheme.titleSmall,
                                softWrap: true,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          HtmlWidget(
                            widget.recruiterData?.seeker?.aboutMe ?? "No Data",
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: const Color(0xffCFCFCF)),
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Image.asset(
                                'assets/images/icon work experience.png',
                                height: Get.height * .03,
                              )),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Work experience',
                                  style: Get.theme.textTheme.titleSmall!
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.workExpJob ==
                                      null ||
                                  widget.recruiterData?.workExpJob
                                          ?.length ==
                                      0
                              ? const Text("No Data")
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.recruiterData?.workExpJob?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.workExpJob?[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HtmlWidget(
                                          data?.workExpJob ?? "",
                                          textStyle: Get
                                              .theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        // Text(CommonFunctions.parseHTML(data?.workExpJob ?? ""),style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(
                                          height: Get.height * 0.001,
                                        ),
                                        HtmlWidget(
                                          data?.companyName ?? "",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        // Text( CommonFunctions.parseHTML(data?.companyName ?? ""),style: Theme.of(context).textTheme.bodySmall!
                                        //     .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        // ),
                                        Text(
                                          "${data?.jobStartDate.toString().replaceAll("00:00:00.000", "")} - ${data?.jobEndDate.toString().replaceAll("00:00:00.000", "")}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * .01,
                                        )
                                      ],
                                    );
                                  }),

                          //******************** for Education **************************
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: Image.asset(
                                    'assets/images/icon education.png',
                                    height: Get.height * .037,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      'Education',
                                      style: Get.theme.textTheme.titleSmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.educationLevel ==
                                      null ||
                                  widget.recruiterData
                                          ?.educationLevel?.length ==
                                      0
                              ? const Text("No Data")
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.recruiterData?.educationLevel?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.educationLevel?[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.educationLevel ?? "",
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.001,
                                        ),
                                        Text(
                                          data?.institutionName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${data?.educationStartDate.toString().replaceAll("00:00:00.000", "")} - ${data?.educationEndDate.toString().replaceAll("00:00:00.000", "")}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * .01,
                                        )
                                      ],
                                    );
                                  }),

                          //******************** for Skill **************************
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: Image.asset(
                                    'assets/images/skillsvg.png',
                                    height: Get.height * .03,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Skill',
                                      style: Get.theme.textTheme.labelMedium!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.skillName == null ||
                                  widget.recruiterData?.skillName?.length == 0
                              ? const Text("No Data")
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          mainAxisExtent: 36,
                                          maxCrossAxisExtent: Get.width * 0.4,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8),
                                  itemCount: widget.recruiterData?.skillName?.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.skillName?[index];
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.blackdown,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        '${data?.skills}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: Image.asset(
                                    'assets/images/appreciation.png',
                                    height: Get.height * .03,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      'Language',
                                      style: Get.theme.textTheme.titleSmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.language == null ||
                                  widget.recruiterData?.language?.length == 0
                              ? const Text("No Data")
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          mainAxisExtent: 36,
                                          maxCrossAxisExtent: Get.width * 0.4,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8),
                                  itemCount: widget.recruiterData?.skillName?.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.skillName?[index];
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.blackdown,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        '${data?.skills}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: SvgPicture.asset(
                                    'assets/images/language.svg',
                                    height: Get.height * .03,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Text(
                                    'Appreciation',
                                    style: Get.theme.textTheme.titleSmall!
                                        .copyWith(color: AppColors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.appreciation == null ||
                                  widget.recruiterData?.appreciation?.length == 0
                              ? const Text("No Data")
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.recruiterData?.appreciation?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.appreciation?[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.achievement ?? "",
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.001,
                                        ),
                                        Text(
                                          data?.awardName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                      ],
                                    );
                                  }),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: Get.height * 0.07,
                                    child: MyButton(
                                        onTap1: () {}, title: 'ACCEPT'),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        20), // Adding spacing between buttons
                                Expanded(
                                  child: SizedBox(
                                    height: Get.height * 0.07,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                          )),
                                      onPressed: () {},
                                      child: Text(
                                        'REJECT',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                        ],
                      )),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
