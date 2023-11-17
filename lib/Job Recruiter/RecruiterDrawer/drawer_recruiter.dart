import 'package:flikka/Job%20Recruiter/RecruiterTraking/applicant_traking.dart';
import 'package:flikka/Job%20Recruiter/metting_list/metting_list_tabbar.dart';
import 'package:flikka/Job%20Recruiter/RecruiterRequest/request.dart';
import 'package:flikka/Job%20Seeker/ChartReport/chart_report.dart';
import 'package:flikka/controllers/LogoutController/LogoutController.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/hiring%20Manager/Applicant_Tracking/applicant_tracking_tabbar.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Job Seeker/SeekerNotification/notification.dart';
import '../../Job Seeker/SeekerNotification/setting_page.dart';
import '../saved_post_recruiter.dart';

class DrawerRecruiter extends StatefulWidget {
  const DrawerRecruiter({super.key});

  @override
  State<DrawerRecruiter> createState() => _DrawerRecruiterState();
}

class _DrawerRecruiterState extends State<DrawerRecruiter> {

  LogoutController logoutController = Get.put(LogoutController()) ;
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back() ;
                    },
                  ) ,
                  Positioned(
                    right: 0,
                    child: Container(
                      //height: Get.height * 1.43,
                      width: Get.width * 0.62,
                      color: Colors.transparent,
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: Get.height*.27,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: AppColors.blueThemeColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height*.026,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius:45,
                                          backgroundColor: const Color(0xffE94D8A).withOpacity(0.3),
                                          backgroundImage:  NetworkImage(viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.profileImg ?? "assets/images/icon_recruiter_drawer.png"),
                                          //backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=764&q=80'),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyName ?? "No Data",
                                          style: Get.theme.textTheme.titleSmall,
                                        ),
                                        SizedBox(
                                          height: Get.height*.002,
                                        ),
                                        Text(
                                          viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyLocation ?? "No Data",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Container(
                            height: Get.height/1.4,
                            color: const Color(0xff353535),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Get.offAll(TabScreen(index: 0,));
                                    },
                                    child: ListTile(
                                      horizontalTitleGap:0,
                                      dense: true,
                                      leading: IconButton(
                                          onPressed: () {
                                            // Get.to(HomePage());
                                          },
                                          icon: Image.asset('assets/images/homedrawericon.png')
                                      ),
                                      title: InkWell(
                                          onTap: () {
                                            // Get.offAll(TabScreen(index: 0));
                                          },
                                          child: Text(
                                            "Home",
                                            style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                          )),
                                    ),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to(AboutPage());
                                        },
                                        icon: Image.asset('assets/images/profiledrawericon.png')
                                    ),
                                    title: InkWell(
                                        onTap: (){
                                          // Get.to(()=>UserProfile());
                                        },
                                        child: Text(
                                          "Profile",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          // Get.to(NewArrivals());
                                        },
                                        icon: Image.asset('assets/images/interviewdrawericon.png',scale: 2.8,fit: BoxFit.cover,)
                                    ),
                                    title: InkWell(
                                      onTap: () {
                                        Get.to(MettingListTabbar());
                                      },
                                      child: Text(
                                        "Interviews",
                                        style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {

                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((ResetPassword()));
                                        },
                                        icon: Image.asset('assets/images/icon_applicant.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to(() => const ApplicantTracking());
                                        } ,
                                        child: Text(
                                          "Applicant Tracking",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      // Get.to(() =>SavedPost());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((ResetPassword()));
                                        },
                                        icon: Image.asset('assets/images/icon_hiring.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to((ApplicantTrackingHiringManager()));
                                        } ,
                                        child: Text(
                                          "Hiring Manager Account",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          // Get.to((ApplicantTrackingHiringManager()));
                                        },
                                        icon: Image.asset('assets/images/icon_job_post.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          //Get.to(() =>CompanySeekerPage());
                                        } ,
                                        child: Text(
                                          "Job Post",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((ResetPassword()));
                                        },
                                        icon: Image.asset('assets/images/icon_report.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to(() =>ChartReport());
                                        } ,
                                        child: Text(
                                          "Report",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {

                                        },
                                        icon: Image.asset('assets/images/icon_saved_post_drawer.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to((SavedPostRecuiter()));
                                        } ,
                                        child: Text(
                                          "Save Post",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((ResetPassword()));
                                        },
                                        icon: Image.asset('assets/images/icon_request.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to(() =>Request());
                                        } ,
                                        child: Text(
                                          "Request",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((ResetPassword()));
                                        },
                                        icon: Image.asset('assets/images/notificationdrawericon.png',scale: 2.8,fit: BoxFit.cover,)),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to(() =>const Notification1());
                                        } ,
                                        child: Text(
                                          "Notificationst",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((MyOrder()));
                                        },
                                        icon: Image.asset('assets/images/aboutdrawericon.png',scale: 2.8,fit: BoxFit.cover,)
                                    ),
                                    title: InkWell(
                                        onTap: () {},
                                        child: Text(
                                          "About",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      // Get.to(() =>SettingPage());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: IconButton(
                                        onPressed: () {
                                          //Get.to((Wishlist()));
                                        },
                                        icon: Image.asset('assets/images/settingdrawericon.png',scale: 2.8,fit: BoxFit.cover,)
                                    ),
                                    title: InkWell(
                                        onTap: () {
                                          Get.to(() =>const SettingPage());
                                        },
                                        child: Text(
                                          "Setting",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    onTap: () {
                                      logoutController.logout() ;
                                      showLogoutDialog(context) ;
                                    },
                                    leading: IconButton(
                                        onPressed: () {

                                        },
                                        icon: Image.asset('assets/images/logoutdrawericon.png',scale: 3,fit: BoxFit.cover,)
                                    ),
                                    title: Text(
                                      "Logout",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(height: Get.height*.2,),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],

              ),
            ),
          ),
        ]),
      );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(backgroundColor: Color(0xff353535),)) ,
                    SizedBox(width: Get.width*.1,),
                    Text("Logging out...",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),) ,
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }
}
