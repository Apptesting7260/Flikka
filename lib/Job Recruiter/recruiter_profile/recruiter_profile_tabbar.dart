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
              endDrawer: DrawerRecruiter(),
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
                              padding:  EdgeInsets.only(top: 15,bottom: 10,right: 10),
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
                child: Column(children: [
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
                                viewRecruiterProfileController
                                        .viewRecruiterProfile
                                        .value
                                        .recruiterProfileDetails
                                        ?.profileImg ??
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
                        // SizedBox(
                        //   height: Get.height * .002,
                        // ),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     "Web And App Development Company",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .labelLarge
                        //         ?.copyWith(
                        //             fontWeight: FontWeight.w400,
                        //             color: Color(0xffCFCFCF)),
                        //   ),
                        // ),
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
              // body: DefaultTabController(
              //   initialIndex: pageIndex,
              //   length: 3,
              //   child: Scaffold(
              //     endDrawer: const DrawerRecruiter(),
              //     backgroundColor: Colors.black,
              //
              //     appBar: PreferredSize(
              //       preferredSize: Size.fromHeight(MediaQuery
              //           .of(context)
              //           .size
              //           .height * 0.52),
              //       child: AppBar(
              //         actions: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 12.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 Builder(
              //                     builder: (context) {
              //                       return InkWell(
              //                           onTap: () =>
              //                               Scaffold.of(context).openEndDrawer(),
              //                           child: Image.asset(
              //                             'assets/images/inactive.png',
              //                             height: Get.height * .055,));
              //                     }
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //         elevation: 0,
              //         backgroundColor: Colors.black,
              //         // leading: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.03,),
              //         flexibleSpace: Container(
              //           margin: EdgeInsets.only(bottom: 10),
              //           child: Column(
              //             children: [
              //               SizedBox(height: Get.height * .027,),
              //               Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: 16),
              //                 child: Row(
              //                   children: [
              //                     SizedBox(height: Get.height*.1,) ,
              //                     Row(
              //                       children: [
              //                         Text(
              //                           'Example Company Inc.',
              //                           style: Theme
              //                               .of(context)
              //                               .textTheme
              //                               .headlineSmall
              //                               ?.copyWith(
              //                               fontWeight: FontWeight.w700),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(height: Get.height * .015,),
              //               Stack(
              //                 clipBehavior: Clip.none,
              //                 children: [
              //                   Container(
              //                     height: Get.height * .18,
              //                     width: Get.width,
              //                     decoration:  BoxDecoration(
              //                         image: DecorationImage(image: NetworkImage(
              //                             viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.coverImg ?? "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png"),
              //                             fit: BoxFit.cover)
              //                     ),
              //                   ),
              //                   Positioned(
              //                       bottom: -40,
              //                       left: 10,
              //                       child: CircleAvatar(
              //                         radius: Get.width*.13,
              //                         backgroundImage: NetworkImage(
              //                         viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.profileImg ??
              //                             "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png",),
              //                       ))
              //                 ],
              //               ),
              //               const SizedBox(height: 50,),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 15),
              //                 child: Column(
              //                   children: [
              //                     SizedBox(height: Get.height * .017,),
              //                     Align(
              //                       alignment: Alignment.topLeft,
              //                       child: Text(
              //                         viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyName ?? "No data",
              //                         style: Theme
              //                             .of(context)
              //                             .textTheme
              //                             .headlineSmall
              //                             ?.copyWith(fontWeight: FontWeight.w700),
              //                       ),
              //                     ),
              //                     SizedBox(height: Get.height * .002,),
              //                     Align(
              //                       alignment: Alignment.topLeft,
              //                       child: Text(
              //                         "Web And App Development Company",
              //                         style: Theme
              //                             .of(context)
              //                             .textTheme
              //                             .labelLarge
              //                             ?.copyWith(fontWeight: FontWeight.w400,
              //                             color: Color(0xffCFCFCF)),
              //                       ),
              //                     ),
              //
              //                   ],
              //                 ),
              //               )
              //
              //             ],
              //           ),
              //         ),
              //         bottom: TabBar(
              //           indicatorPadding: EdgeInsets.symmetric(
              //               horizontal: Get.width * .02),
              //           //labelPadding: EdgeInsets.only(right: 72),
              //           isScrollable: true,
              //           indicator: const UnderlineTabIndicator(
              //             borderSide: BorderSide(width: 2.0, color: Color(
              //                 0xff56B8F6)),
              //             //insets: EdgeInsets.symmetric(horizontal: width*.14),
              //           ),
              //           physics: const AlwaysScrollableScrollPhysics(),
              //           unselectedLabelColor: const Color(0xffCFCFCF),
              //           labelColor: const Color(0xff56B8F6),
              //           labelStyle: Theme
              //               .of(context)
              //               .textTheme
              //               .bodyMedium,
              //           tabs: const [
              //             Tab(text: "HOME"),
              //             Tab(text: "ABOUT",),
              //             Tab(text: "JOBS",),
              //           ],
              //         ),
              //       ),
              //     ),
              //     body: TabBarView(
              //       children: [
              //         RecruiterHome(recruiterProfileDetails: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails,),
              //         RecruiterAbout(recruiterProfileDetails: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails,),
              //         RecruiterJobs(recruiterJobsData: viewRecruiterProfileController.viewRecruiterProfile.value.jobs,
              //         company: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyName,
              //           location: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyLocation,
              //         ),
              //
              //       ],
              //     ),
              //   ),

              );
      }
    });
  }
}
