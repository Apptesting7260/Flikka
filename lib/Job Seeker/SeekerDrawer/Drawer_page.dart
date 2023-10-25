import 'package:flikka/Job%20Recruiter/metting_list/metting_list_tabbar.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flikka/Job%20Seeker/SeekerCompanies/companies_seeker_page.dart';
import 'package:flikka/Job%20Seeker/Authentication/user/user_profile.dart';
import 'package:flikka/controllers/LogoutController/LogoutController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_colors.dart';
import '../SeekerNotification/notification.dart';
import '../SeekerNotification/setting_page.dart';
import '../saved_post_widget.dart';
import '../SeekerBottomNavigationBar/tab_bar.dart';

class DrawerClass extends StatefulWidget {
  final String? name ;
  final String? location ;
  final String? jobTitle ;
  final String? profileImage ;
  const DrawerClass({super.key, required this.name, required this.location, required this.jobTitle, this.profileImage});

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {

  LogoutController logoutController  = Get.put( LogoutController()) ;

  String homeIcon = 'assets/images/homedrawericon.png' ;
  String profileIcon = 'assets/images/profiledrawericon.png' ;
  String interviewIcon = 'assets/images/interviewdrawericon.png' ;
  String notificationIcon = 'assets/images/notificationdrawericon.png' ;
  String savePostIcon = 'assets/images/icon_saved_post_drawer.png' ;
  String companyIcon = 'assets/images/icon_companies.png' ;
  String forumIcon = 'assets/images/icon_forum.png' ;
  String aboutIcon = 'assets/images/aboutdrawericon.png' ;
  String settingIcon = 'assets/images/settingdrawericon.png' ;
  String logoutIcon = 'assets/images/logoutdrawericon.png' ;
  String messageIcon = 'assets/images/icon_message.png' ;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              //height: Get.height * 1.43,
              width: Get.width * 0.62,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: Get.height*.28,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Color(0xFF4D6FED),//
                          //     Color(0xff00008b),
                          //   ],
                          //   begin: Alignment.bottomCenter,
                          //   end: Alignment.topCenter,
                          // )
                          color: AppColors.blueThemeColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*.02,),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius:42,
                                  backgroundImage: NetworkImage("${widget.profileImage}"),

                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text("${widget.name}",
                                  style: Get.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: Get.height*.002,
                                ),
                                Text(
                                    "${widget.jobTitle}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall?.copyWith(color: Color(0xffFFFFFF),fontWeight: FontWeight.w600)
                                ),
                                SizedBox(
                                  height: Get.height*.002,
                                ),
                                Text(
                                  "${widget.location}",
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
                          ListTile(
                            onTap: () {
                              Get.offAll(const TabScreen(index: 0));
                            },
                            horizontalTitleGap:0,
                            dense: true,
                            leading: drawerIcon(homeIcon) ,
                            title: Text(
                              "Home",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            horizontalTitleGap:0,
                            onTap: () {
                              Get.to(() => const UserProfile());
                            },
                            dense: true,
                            leading: drawerIcon(profileIcon) ,
                            title: Text(
                              "Profile",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            horizontalTitleGap:0,
                            dense: true,
                            onTap: () {
                              Get.to(const MettingListTabbar());
                            },
                            leading: drawerIcon(interviewIcon),
                            title: Text(
                              "Interviews",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const Notification1());
                            },
                            horizontalTitleGap:0,
                            dense: true,
                            leading: drawerIcon(notificationIcon),
                            title: Text(
                              "Notifications",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() =>const SavedPost());
                            },
                            horizontalTitleGap:0,
                            dense: true,
                            leading: drawerIcon(savePostIcon) ,
                            title: Text(
                              "Save Post",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            horizontalTitleGap:0,
                            onTap: (){
                              Get.to(() =>const CompanySeekerPage());
                            } ,
                            dense: true,
                            leading: drawerIcon(companyIcon) ,
                            title: Text(
                              "Companies",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            horizontalTitleGap:0,
                            onTap: (){
                              Get.to(() =>const MessagePage());
                            } ,
                            dense: true,
                            leading: drawerIcon(messageIcon) ,
                            title: Text(
                              "Message",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            horizontalTitleGap:0,
                            dense: true,
                            leading: drawerIcon(aboutIcon) ,
                            title: Text(
                              "About",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() =>const SettingPage());
                            },
                            horizontalTitleGap:0,
                            dense: true,
                            leading: drawerIcon(settingIcon) ,
                            title: Text(
                              "Setting",
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                          ),
                          ListTile(
                            horizontalTitleGap:0,
                            dense: true,
                            onTap: () {
                              logoutController.logout() ;
                              showLogoutDialog(context)  ;
                            },
                            leading: drawerIcon(logoutIcon) ,
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
        ]),
      );
  }

  drawerIcon ( String image ) {
    return Image.asset(image,height: 22,fit: BoxFit.cover,) ;
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
