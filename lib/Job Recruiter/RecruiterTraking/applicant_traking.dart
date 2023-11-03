
 import 'package:flikka/Job%20Recruiter/RecruiterTraking/inbox.dart';
import 'package:flikka/Job%20Recruiter/RecruiterTraking/talent_pool.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';

import 'all_candidate.dart';
import 'rejected_candidate.dart';
import 'upcoming_interviews.dart';

class ApplicantTracking extends StatefulWidget {
  const ApplicantTracking({super.key});

  @override
  State<ApplicantTracking> createState() => _ApplicantTrackingState();
}

class _ApplicantTrackingState extends State<ApplicantTracking> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff000),
            title: Text(
                      'Applicant Tracking',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
            leading: Padding(
              padding:  EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                  child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.02,)),
            ),
            bottom: TabBar(
          indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width*.04),
          //labelPadding: EdgeInsets.only(right: 50),
          isScrollable: true,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0,color: AppColors.blueThemeColor),
            //insets: EdgeInsets.symmetric(horizontal: width*.14),
          ),
          physics: AlwaysScrollableScrollPhysics(),
          unselectedLabelColor: AppColors.graySilverColor,
          labelColor: AppColors.blueThemeColor,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          tabs: const [
            Tab(text: "APPLICANT DATA"),
            Tab(text: "INTERVIEWS",),
            Tab(text: "INBOX",),
            Tab(text: "TALENT POOL",),
          ],
        ),
          ),

          body: const TabBarView(
            children: [
              AllCandidate(),
              UpcomingInterviews(),
              Inbox(),
              TalentPool(),
            ],
          ),
        ),
      ),
    );
  }
}
