import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/about.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/home.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/jobs.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/review.dart';
import 'package:flikka/Job%20Seeker/SeekerDrawer/Drawer_page.dart';
import 'package:flikka/controllers/SeekerViewCompanyController/SeekerViewCompanyController.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../bottom_bar/tab_bar.dart';
import 'benchmark.dart';

class RecruiterProfileTabBar extends StatefulWidget {
 final int? index; final bool? isSeeker ; final String? recruiterID ;
  const RecruiterProfileTabBar({ this.index, this.isSeeker, this.recruiterID , super.key,});

  @override
  State<RecruiterProfileTabBar> createState() => _RecruiterProfileTabBarState();
}

class _RecruiterProfileTabBarState extends State<RecruiterProfileTabBar> {
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());
  SeekerViewCompanyController seekerViewCompanyController = Get.put(SeekerViewCompanyController()) ;
  int pageIndex = 0;

  String? name ;
  String? position ;
  String? location ;
  String? profileImg ;


  @override
  void initState() {
    pageIndex = widget.index ?? 0;
    if(widget.isSeeker == null || widget.isSeeker == false) {
      viewRecruiterProfileController.viewRecruiterProfileApi();
    } else {
      seekerViewCompanyController.viewCompany(widget.recruiterID) ;
      name = Get.arguments["SeekerName"] ;
      location = Get.arguments["seekerLocation"] ;
      position =  Get.arguments["seekerPosition"] ;
      profileImg =  Get.arguments["seekerProfileImg"] ;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSeeker == null || widget.isSeeker == false) {
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
                onPress: () {
                  viewRecruiterProfileController.viewRecruiterProfileApi();
                },
              );
            } else {
              return Scaffold(
                  backgroundColor: Color(0xff000),
                  body: GeneralExceptionWidget(onPress: () {
                    viewRecruiterProfileController.viewRecruiterProfileApi();
                  }));
            }
          case Status.COMPLETED:
            return Scaffold(
                endDrawer: const DrawerRecruiter(),
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Get.offAll(TabScreenEmployer(index: 0));
                        },
                        child: Image.asset('assets/images/icon_back_blue.png')),
                  ),
                  title: Text(
                    viewRecruiterProfileController.viewRecruiterProfile.value
                        .recruiterProfileDetails?.companyName ?? "",
                    style: Theme
                        .of(context)
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
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 10, right: 10),
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
                  length: 4,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          if (details.delta.dy > 40) {
                            print("object");
                            viewRecruiterProfileController.refreshApi();
                          }
                        },
                        child: Column(
                            children: [
                              Obx(() =>
                              viewRecruiterProfileController.refreshLoading.value ?
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ) : const SizedBox()
                              ),
                              SizedBox(height: Get.height * .025,),
                              SizedBox(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: Get.height * .18,
                                      width: Get.width,
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                        imageUrl:  viewRecruiterProfileController.viewRecruiterProfile.value.
                                    recruiterProfileDetails?.coverImg ??
                                        "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png",
                                    // imageBuilder: (context, imageProvider) =>  Container(
                                    //   height: Get.height * .18,
                                    //   width: Get.width,
                                    // ),
                                    ),
                                    // Container(
                                    //   height: Get.height * .18,
                                    //   width: Get.width,
                                    //   decoration: BoxDecoration(
                                    //       image: DecorationImage(
                                    //           image: NetworkImage(
                                    //               viewRecruiterProfileController
                                    //                   .viewRecruiterProfile
                                    //                   .value
                                    //                   .recruiterProfileDetails
                                    //                   ?.coverImg ??
                                    //                   "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png"),
                                    //           fit: BoxFit.cover)),
                                    // ),
                                    Positioned(
                                        bottom: -40,
                                        left: 10,
                                        child: CircleAvatar(
                                          radius: Get.width * .13,
                                          backgroundImage: NetworkImage(
                                            viewRecruiterProfileController
                                                .viewRecruiterProfile.value
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * .017,
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                      children: [
                                        Text(
                                          viewRecruiterProfileController
                                              .viewRecruiterProfile
                                              .value
                                              .recruiterProfileDetails
                                              ?.companyName ??
                                              "",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  RecruiterProfileEdit(
                                                    profileModel: viewRecruiterProfileController
                                                        .viewRecruiterProfile
                                                        .value,));
                                            },
                                            child: Image.asset(
                                              "assets/images/icon_edit.png",
                                              height: 18,))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * .018,),
                              TabBar(
                                indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                                isScrollable: true,
                                indicator: const UnderlineTabIndicator(
                                  borderSide:
                                  BorderSide(width: 2.0, color: AppColors.blueThemeColor),),
                                physics: const AlwaysScrollableScrollPhysics(),
                                unselectedLabelColor: const Color(0xffCFCFCF),
                                labelColor: AppColors.blueThemeColor,
                                labelStyle: Theme.of(context).textTheme.bodyMedium,
                                tabs: const [
                                  Tab(text: "HOME"),
                                  Tab(text: "ABOUT",),
                                  Tab(text: "JOBS",),
                                  Tab(text: "Review",),
                                ],
                              ),
                              Flexible(
                                child: TabBarView(
                                  children: [
                                    RecruiterHome(
                                      recruiterProfileDetails: viewRecruiterProfileController
                                          .viewRecruiterProfile.value
                                          .recruiterProfileDetails,
                                    ),
                                    RecruiterAbout(
                                      recruiterProfileDetails: viewRecruiterProfileController
                                          .viewRecruiterProfile.value
                                          .recruiterProfileDetails,
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
                                    const Review(isSeeker: false,),
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
    } else {
      return Obx(() {
        switch (seekerViewCompanyController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              backgroundColor: Color(0xff000),
              body: Center(child: CircularProgressIndicator()),
            );
          case Status.ERROR:
            if (seekerViewCompanyController.error.value == 'No internet') {
              return InterNetExceptionWidget(
                onPress: () {
                  seekerViewCompanyController.viewCompany(widget.recruiterID) ;
                },
              );
            } else {
              return Scaffold(
                  backgroundColor: const Color(0x000ff000),
                  body: GeneralExceptionWidget(onPress: () {
                    seekerViewCompanyController.viewCompany(widget.recruiterID) ;
                  }));
            }
          case Status.COMPLETED:
            return Scaffold(
                endDrawer: DrawerClass(
                    name: name ?? "", location: location ?? "", jobTitle: position ?? "",
                  profileImage: profileImg ?? "" ,),
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset('assets/images/icon_back_blue.png')),
                  ),
                  title: Text(
                    seekerViewCompanyController.companyData.value.recruiterProfileDetails?.companyName ?? "",
                    style: Theme
                        .of(context)
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
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 10, right: 10),
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
                  length: 4,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          if (details.delta.dy > 40) {
                            seekerViewCompanyController.viewCompany(widget.recruiterID) ;
                          }
                        },
                        child: Column(
                            children: [
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
                                              image: NetworkImage(
                                                  seekerViewCompanyController.companyData.value.recruiterProfileDetails?.coverImg ??
                                                      "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png"),
                                              fit: BoxFit.cover)),
                                    ),
                                    Positioned(
                                        bottom: -40,
                                        left: 10,
                                        child: CircleAvatar(
                                          radius: Get.width * .13,
                                          backgroundImage: NetworkImage(
                                            seekerViewCompanyController.companyData.value.recruiterProfileDetails?.profileImg ??
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * .017,
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                      children: [
                                        Text(
                                          seekerViewCompanyController.companyData.value.recruiterProfileDetails
                                              ?.companyName ?? "",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * .018,),
                              TabBar(
                                indicatorPadding:
                                EdgeInsets.symmetric(
                                    horizontal: Get.width * .02),
                                isScrollable: true,
                                indicator: const UnderlineTabIndicator(
                                  borderSide:
                                  BorderSide(width: 2.0,
                                      color: AppColors.blueThemeColor),
                                ),
                                physics: const AlwaysScrollableScrollPhysics(),
                                unselectedLabelColor: const Color(
                                    0xffCFCFCF),
                                labelColor: AppColors.blueThemeColor,
                                labelStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                                tabs: const [
                                  Tab(text: "HOME"),
                                  Tab(text: "ABOUT",),
                                  Tab(text: "JOBS",),
                                  Tab(text: "Review",),
                                ],
                              ),
                              Flexible(
                                // flex: 4,
                                child: TabBarView(
                                  children: [
                                    RecruiterHome(
                                      recruiterProfileDetails: seekerViewCompanyController.companyData.value.recruiterProfileDetails,
                                    ),
                                    RecruiterAbout(
                                      recruiterProfileDetails: seekerViewCompanyController.companyData.value.recruiterProfileDetails,
                                    ),
                                    RecruiterJobs(
                                      recruiterJobsData: seekerViewCompanyController.companyData.value.jobs,
                                      company: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.companyName,
                                      location: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.companyLocation,
                                      isSeeker: true,
                                    ),
                                    const Review(isSeeker: true,),
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
}
