import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/about.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/home.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/jobs.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class RecruiterProfileTabBar extends StatefulWidget {
  int? index;

  RecruiterProfileTabBar({
    this.index,
    super.key,
  });

  @override
  State<RecruiterProfileTabBar> createState() => _RecruiterProfileTabBarState();
}

class _RecruiterProfileTabBarState extends State<RecruiterProfileTabBar> {
  ViewRecruiterProfileGetController viewRecruiterProfileController =
      Get.put(ViewRecruiterProfileGetController());

  int pageIndex = 0;

  @override
  void initState() {
    pageIndex = widget.index ?? 0;
    viewRecruiterProfileController.viewRecruiterProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (viewRecruiterProfileController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            backgroundColor: Color(0xff000),
            body: Center(child: CircularProgressIndicator()),
          );
        case Status.ERROR:
          if (viewRecruiterProfileController.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {},
            );
          } else {
            return Scaffold(
                backgroundColor: Color(0xff000),
                body: GeneralExceptionWidget(onPress: () {}));
          }
        case Status.COMPLETED:
          return Scaffold(
              endDrawer: const DrawerRecruiter(),
              appBar: AppBar(
                title: Text(
                  viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyName ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                actions: [
                   Builder(
                     builder: (context) {
                       return InkWell(
                            onTap: () => Scaffold.of(context).openEndDrawer(),
                            child: Padding(
                              padding:  const EdgeInsets.only(top: 15,bottom: 10,right: 10),
                              child: Image.asset(
                                'assets/images/inactive.png',
                                height: Get.height * .05,
                              ),
                            ));
                     }
                   )

                ],
              ),
              body: DefaultTabController(
                initialIndex: pageIndex,
                length: 3,
                child: Stack(
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.delta.dy > 40) {
                          print("object") ;
                          viewRecruiterProfileController.refreshApi() ;
                        }
                      },
                      child: Column(
                          children: [
                            Obx(() => viewRecruiterProfileController.refreshLoading.value ?
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ): const SizedBox()
                            ),
                            SizedBox(height: Get.height * .025,),
                            SizedBox(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: Get.height * .18,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(viewRecruiterProfileController
                                                .viewRecruiterProfile
                                                .value
                                                .recruiterProfileDetails
                                                ?.coverImg ??
                                                "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                      bottom: -40,
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: Get.width * .13,
                                        backgroundImage: NetworkImage(
                                          viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.profileImg ??
                                              "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png",
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * .017,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      viewRecruiterProfileController
                                          .viewRecruiterProfile
                                          .value
                                          .recruiterProfileDetails
                                          ?.companyName ??
                                          "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Get.height*.018,) ,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                  indicatorPadding:
                                  EdgeInsets.symmetric(horizontal: Get.width * .02),
                                  //labelPadding: EdgeInsets.only(right: 72),
                                  isScrollable: true,
                                  indicator: const UnderlineTabIndicator(
                                    borderSide:
                                    BorderSide(width: 2.0, color: AppColors.blueThemeColor),
                                    //insets: EdgeInsets.symmetric(horizontal: width*.14),
                                  ),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  unselectedLabelColor: const Color(0xffCFCFCF),
                                  labelColor: AppColors.blueThemeColor,
                                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                                  tabs: const [
                                    Tab(text: "HOME"),
                                    Tab(
                                      text: "ABOUT",
                                    ),
                                    Tab(
                                      text: "JOBS",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Flexible(
                              child: TabBarView(
                                children: [
                                  RecruiterHome(
                                    recruiterProfileDetails: viewRecruiterProfileController
                                        .viewRecruiterProfile.value.recruiterProfileDetails,
                                  ),
                                  RecruiterAbout(
                                    recruiterProfileDetails: viewRecruiterProfileController
                                        .viewRecruiterProfile.value.recruiterProfileDetails,
                                  ),
                                  RecruiterJobs(
                                    recruiterJobsData: viewRecruiterProfileController
                                        .viewRecruiterProfile.value.jobs,
                                    company: viewRecruiterProfileController
                                        .viewRecruiterProfile
                                        .value
                                        .recruiterProfileDetails
                                        ?.companyName,
                                    location: viewRecruiterProfileController
                                        .viewRecruiterProfile
                                        .value
                                        .recruiterProfileDetails
                                        ?.companyLocation,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              )
              );
      }
    });
  }
}
