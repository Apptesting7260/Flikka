
 import 'package:flikka/Job%20Recruiter/RecruiterTraking/inbox.dart';
import 'package:flikka/Job%20Recruiter/RecruiterTraking/talent_pool.dart';
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
        child: Scaffold(backgroundColor: Colors.black,
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
            borderSide: BorderSide(width: 2.0,color: Color(0xff56B8F6)),
            //insets: EdgeInsets.symmetric(horizontal: width*.14),
          ),
          physics: AlwaysScrollableScrollPhysics(),
          unselectedLabelColor: Color(0xffCFCFCF),
          labelColor: Color(0xff56B8F6),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          tabs: const [
            Tab(text: "APPLICANT DATA"),
            Tab(text: "INTERVIEWS",),
            Tab(text: "INBOX",),
            Tab(text: "TALENT POOL",),
          ],
        ),
          ),

          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(125),
          //   child: AppBar(
          //     elevation: 0,
          //   backgroundColor: Colors.black,
          //    // leading: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.03,),
          //     flexibleSpace: Container(
          //       alignment: Alignment.center,
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(horizontal: Get.width*.04,vertical: 10),
          //
          //         child: Row(
          //           // crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             GestureDetector(
          //                 onTap: () {
          //                   Get.back();
          //                 },
          //                 child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)),
          //             SizedBox(width: Get.width*.04,),
          //             Text(
          //               'Applicant Tracking',
          //               style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     bottom: TabBar(
          //       indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width*.04),
          //       //labelPadding: EdgeInsets.only(right: 50),
          //       isScrollable: true,
          //       indicator: UnderlineTabIndicator(
          //         borderSide: BorderSide(width: 2.0,color: Color(0xff56B8F6)),
          //         //insets: EdgeInsets.symmetric(horizontal: width*.14),
          //       ),
          //       physics: AlwaysScrollableScrollPhysics(),
          //       unselectedLabelColor: Color(0xffCFCFCF),
          //       labelColor: Color(0xff56B8F6),
          //       labelStyle: Theme.of(context).textTheme.bodyMedium,
          //       tabs: const [
          //         Tab(text: "Applicants Data"),
          //         Tab(text: "Interviews",),
          //         Tab(text: "Inbox",),
          //         Tab(text: "Talent Pool",),
          //       ],
          //     ),
          //   ),
          // ),
          body: TabBarView(
            children: [
              AllCandidate(),
              UpcomingInterviews(),
              Inbox(),
              TalentPool(),
              // SelectedCandidate(),
              // RejectedCandidate(),

            ],
          ),
        ),
      ),
    );
  }
}
