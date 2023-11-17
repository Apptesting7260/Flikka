import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/RecruiterHomeModel/RecruiterHomeModel.dart';


class ViewCandidateProfile extends StatefulWidget {
  final RecruiterHomeData? recruiterData ;
  const ViewCandidateProfile({Key? key, this.recruiterData}) : super(key: key);


  @override
  State<ViewCandidateProfile> createState() => _ViewCandidateProfileState();
}

class _ViewCandidateProfileState extends State<ViewCandidateProfile> {

  ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());

  String uri = '';

  //********************* for workexperience *************
  TextEditingController workexperienceController = TextEditingController();
  void workexperience() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add experience",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: workexperienceController,
            decoration: InputDecoration(
              hintText: 'your experience',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
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

  //********************* for education *************
  TextEditingController educationController = TextEditingController();
  void education() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add education",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: educationController,
            decoration: InputDecoration(
              hintText: 'Write your education',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
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

  //********************* for skill *************
  TextEditingController skillController = TextEditingController();
  void skill() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add skill",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: skillController,
            decoration: InputDecoration(
              hintText: 'Write your skill',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
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

  //********************* for language *************
  TextEditingController languageController = TextEditingController();
  void language() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add language",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: languageController,
            decoration: InputDecoration(
              hintText: 'Write your language',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
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

  //********************* for appreciation *************
  TextEditingController appreciationController = TextEditingController();
  void appreciation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add appreciation",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: appreciationController,
            decoration: InputDecoration(
              hintText: 'Write your appreciation',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
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


  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
          children:[
            Container(
              decoration: const BoxDecoration(
              color: AppColors.blueThemeColor
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: SvgPicture.asset('assets/images/backiconsvg.svg')),
                          SizedBox(width: Get.width*0.035,),
                          Text( widget.recruiterData?.fullname ?? "",style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700)),

                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.0395,),
                    Column(
                      children: [
                        Stack(
                            children: [
                               CircleAvatar(
                                radius:48,
                                backgroundImage: NetworkImage( widget.recruiterData?.profileImg ?? ''),
                              ),
                            ]
                        )
                      ],
                    ),
                    SizedBox(height: Get.height*0.015,),
                    Text( widget.recruiterData?.fullname ?? "",style: Get.theme.textTheme.displayLarge),
                    SizedBox(height: Get.height*0.005,),
                    Text( widget.recruiterData?.seekerData?.positions ?? "",style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
                    SizedBox(height: Get.height*0.005,),
                    Text( widget.recruiterData?.location ?? "",style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
                    SizedBox(height: Get.height*0.015,),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.white
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){},icon: Image.asset('assets/images/messagepng.png')),

                              ],
                            )
                        ),
                        SizedBox(width: Get.width*0.045,),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.white
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){},icon: Image.asset('assets/images/call.png',scale: 0.7,)),

                              ],
                            )
                        ),
                        SizedBox(width: Get.width*0.045,),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.white
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){},icon: Image.asset('assets/images/videocall.png',scale: 0.7)),

                              ],
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height*0.035,),
                    SizedBox(
                      height: Get.height*0.072,
                      width: Get.width*0.69,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)
                        )
                        ),
                        onPressed: (){}, child: Text(
                        'AVAILABLE IMMEDIATELY',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,),
                      ),),
                    )
                  ],
                ),
              ),
            ),
            //************** scrollable functionality *******************
            DraggableScrollableSheet(
              initialChildSize: 0.36, // half screen
              minChildSize: 0.36, // half screen
              maxChildSize: 1, // full screen
              builder: (BuildContext context, ScrollController scrollController) {
                return
                  Container(
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
                            padding:const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                            ),
                            child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        child: Image.asset('assets/images/about.png',height: Get.height*.04,)),
                                    SizedBox(width: Get.width*0.02,),
                                    Text("About",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height*0.015,),
                                const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.02,),
                                Text( widget.recruiterData?.aboutMe ?? "No Data" ,style: Theme.of(context).textTheme
                                      .bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),

                                //********************* for work ex ***************************
                                SizedBox(height: Get.height*0.04,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        child: Image.asset('assets/images/icon work experience.png',height: Get.height*.04,)),
                                    SizedBox(width: Get.width*0.02,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text('Work experience',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height*0.02,),
                                const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.02,),
                                widget.recruiterData?.seekerData?.workExpJob == null ||
                                    widget.recruiterData?.seekerData?.workExpJob?.length == 0 ?
                                const Text("No Data") :
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                    itemCount: widget.recruiterData?.seekerData?.workExpJob?.length,
                                  itemBuilder: (context , index) {
                                    var data = widget.recruiterData?.seekerData?.workExpJob?[index] ;
                                    return Column(
                                      children: [
                                        Text(data?.workExpJob ?? "",style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(height: Get.height*0.01,),
                                        Text( data?.companyName ?? "",style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: AppColors
                                                .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                        Text( "${data?.jobStartDate?.year}-${data?.jobStartDate?.month}-${data?.jobStartDate?.day} - ${data?.jobEndDate}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    );
                                  }
                                ),

                                //********************* for Education ***************************
                                SizedBox(height: Get.height*0.04,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: Image.asset('assets/images/icon education.png',height: Get.height*.05,)),
                                        SizedBox(width: Get.width*0.02,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: Text('Education',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: Get.height*0.02,),
                                const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.02,),
                                widget.recruiterData?.seekerData?.educationLevel == null ||
                                    widget.recruiterData?.seekerData?.educationLevel?.length == 0 ?
                                const Text("No Data") :
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.recruiterData?.seekerData?.educationLevel?.length,
                                  itemBuilder: (context , index) {
                                    var data = widget.recruiterData?.seekerData?.educationLevel?[index] ;
                                    return Column(
                                      children: [
                                        Text(data?.educationLevel ?? "",style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(height: Get.height*0.01,),
                                        Text(data?.institutionName ?? "",style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                        Text( "${data?.educationStartDate?.year}-${data?.educationStartDate?.month}-${data?.educationStartDate?.day} - ${data?.educationEndDate}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    );
                                  }
                                ),

                                //********************* for Skill ***************************
                                SizedBox(height: Get.height*0.04,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: Image.asset('assets/images/skillsvg.png',height: Get.height*.04,)),
                                        SizedBox(width: Get.width*0.02,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child:
                                          Text('Skill',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: Get.height*0.02,),
                                const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.02,),
                                widget.recruiterData?.seekerData?.skillName == null ||
                                    widget.recruiterData?.seekerData?.skillName?.length == 0 ?
                                const Text("No Data") :
                                GridView.builder(gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisExtent: 36,
                                    maxCrossAxisExtent: Get.width * 0.4,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                                    itemCount: widget.recruiterData?.seekerData?.skillName?.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var data = widget.recruiterData?.seekerData?.skillName?[index];
                                      return Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: const EdgeInsets.all(
                                            8),
                                        child: Text('${data?.skills}',
                                          overflow: TextOverflow
                                              .ellipsis,
                                          style: Get.theme.textTheme
                                              .bodySmall!.copyWith(
                                              color: AppColors.white,
                                              fontWeight: FontWeight
                                                  .w400),),
                                      );
                                    }),

                                //********************* for Language ***************************
                                SizedBox(height: Get.height*0.04,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: Image.asset('assets/images/languagesvg.png',height: Get.height*.04,)),
                                        SizedBox(width: Get.width*0.02,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child:
                                          Text('Language',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height*0.02,),
                                const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.02,),
                                // widget.recruiterData?.seekerData?.language == null ||
                                //     seekerProfileController.viewSeekerData.value.seekerDetails?.language?.length == 0 ?
                                // const Text("No Data") :
                                // GridView.builder(gridDelegate:
                                // SliverGridDelegateWithMaxCrossAxisExtent(
                                //     mainAxisExtent: 36,
                                //     maxCrossAxisExtent: Get.width * 0.4,
                                //     mainAxisSpacing: 8,
                                //     crossAxisSpacing: 8),
                                //     itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.language?.length,
                                //     shrinkWrap: true,
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     itemBuilder: (context, index) {
                                //       var data = seekerProfileController
                                //           .viewSeekerData.value
                                //           .seekerDetails
                                //           ?.language?[index];
                                //       return Container( alignment: Alignment.center,
                                //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                //           color: AppColors.blackdown,),
                                //         padding: const EdgeInsets.all(8),
                                //         child: Text('${data?.languages}',
                                //           style: Get.theme.textTheme.bodySmall!.copyWith(
                                //               color: AppColors.white, fontWeight: FontWeight.w400),),
                                //       );
                                //     }),

                                //********************* for appreciation ***************************
                                // SizedBox(height: Get.height*0.04,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: SvgPicture.asset('assets/images/appreciation.svg')),
                                        SizedBox(width: Get.width*0.02,),
                                        Text('Appreciation',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: Get.height*0.02,),
                                const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.02,),
                                widget.recruiterData?.seekerData?.appreciation == null ||
                                    widget.recruiterData?.seekerData?.appreciation?.length == 0 ?
                                const Text("No Data") :
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.recruiterData?.seekerData?.appreciation?.length ,
                                  itemBuilder: (context , index) {
                                    var data = widget.recruiterData?.seekerData?.appreciation?[index] ;
                                    return Column(
                                      children: [
                                        Text(data?.achievement ?? "",style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(height: Get.height*0.01,),
                                        Text(data?.awardName ?? "",style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: AppColors
                                                .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    );
                                  }
                                ),
                                SizedBox(height: Get.height*0.05,),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: Get.height*0.07,
                                          child: MyButton(onTap1: () {}, title: 'ACCEPT'),
                                        ),
                                      ),
                                      SizedBox(width: 20), // Adding spacing between buttons
                                      Expanded(
                                        child: SizedBox(
                                          height: Get.height*0.07,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(60.0),
                                                )
                                            ),
                                            onPressed: () {},
                                            child: Text('REJECT',style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: AppColors.black),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height*0.03,),
                              ],
                            )
                        ),

                      ],
                    ),
                  );
              },
            ),
          ]
      ),
    );
  }

}


