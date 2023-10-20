import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_colors.dart';
import '../widgets/my_button.dart';

class CompanyRecruiter extends StatefulWidget {
  const CompanyRecruiter({super.key});

  @override
  State<CompanyRecruiter> createState() => _CompanyRecruiterState();
}

class _CompanyRecruiterState extends State<CompanyRecruiter> {
  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a Comment",style: Theme.of(context).textTheme.displayLarge,),
          content: TextField(
            style: const TextStyle(
                color: AppColors.white,fontSize: 23
            ),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  bool selectedFav = false;
  Color buttonColor = AppColors.ratingcommenttextcolor;

  void toggleFavorite() {
    setState(() {
      selectedFav = !selectedFav;
      buttonColor = selectedFav ? AppColors.red : AppColors.ratingcommenttextcolor;
    });
  }

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width*.024),
              child: Column(
                  children: [
                    SizedBox(height: Get.height*.03,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                            child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)),
                        SizedBox(width: Get.width*.04,),
                        Text("Company",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),)
                      ],)]),
            ), preferredSize: Size(Get.width, Get.height*.14)),
          body:
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*.024),
            child: Stack(
              children: [
                //*************** for swiper image **************
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28)
                  ),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/swiperbg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //*************** for marketing intern **************

                DraggableScrollableSheet(
                  initialChildSize: 0.5, // half screen
                  minChildSize: 0.5, // half screen
                  maxChildSize: 1, // full screen
                  builder: (BuildContext context, ScrollController scrollController) {
                    return  ListView(
                      controller: scrollController,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: AppColors.blackdown,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                            ),

                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.05),
                              child: Column(
                                children: [
                                  //********************* for jessica  ***************************
                                  Container(

                                    decoration: BoxDecoration(
                                      color: AppColors.blackdown,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Marketing Intern",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          softWrap: true,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "Example Company Pvt. Ltd",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: Color(0xffCFCFCF)),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.04,
                                        ),
                                        Text(
                                          "Job Description",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "Lorem Ipsum he printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",


                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:  Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Requirements",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.015,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "• Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,
                                            ),
                                            Text(
                                              "• Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,
                                            ),
                                            Text(
                                              "• Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Employment type",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "Full Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Type of workplace",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "On-site",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Work experience",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "2 - 4 Years",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Education",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "Graduate",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Language",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.010,
                                        ),
                                        Text(
                                          "Hindi - English",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Soft Skills",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: Get.width*.035,vertical: Get.height*.019),

                                              child: Center(
                                                child:
                                                Text('communication',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: Get.width*.035,vertical: Get.height*.019),

                                              child: Center(
                                                child:
                                                Text('negotiation',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: Get.width*.035,vertical: Get.height*.019),

                                              child: Center(
                                                child:
                                                Text('public speaking',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height*0.015,),
                                        Row(
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('analysis thinking',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Passion",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Passion 1',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Passion 3',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Passion 4',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "industry preference",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('preference 1',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('preference 3',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('preference 4',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Strengths",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 28,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('strengths 1',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 28,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('strengths 3',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 28,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('strengths 4',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Salary expectation",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('\$60,000',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('\$80,000',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('\$90,000',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "When can i start working?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Immediately',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Half - Time',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('part - time',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Availability",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Monday',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Tuesday',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding:EdgeInsets.symmetric(horizontal: 26,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('wednesday',style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                             // padding: EdgeInsets.symmetric(horizontal: 28,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('thursday',style: Get.theme.textTheme.bodySmall!.copyWith(color:Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 35,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Friday',style: Get.theme.textTheme.bodySmall!.copyWith(color:Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),

                                            Container(
                                              height: Get.height*.055,
                                              width: Get.width*.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color(0xff484848),
                                              ),
                                              //padding: EdgeInsets.symmetric(horizontal: 30,vertical: 13),

                                              child: Center(
                                                child:
                                                Text('Saturday',style: Get.theme.textTheme.bodySmall!.copyWith(color:Color(0xffCFCFCF),fontSize: 8,fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height*0.05,),
                                        Center(
                                          child: MyButton(title: 'POST',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                color: AppColors
                                                    .ratingcommenttextcolor,fontWeight: FontWeight.w700, ),
                                              onTap1:(){
                                            print("called") ;
                                                  Get.offAll(TabScreenEmployer(index: 4, profileTabIndex: 2,));
                                              }
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),

                      ],
                    );

                  },
                ),

              ],
            ),
          )
      ),
    );
  }
}
