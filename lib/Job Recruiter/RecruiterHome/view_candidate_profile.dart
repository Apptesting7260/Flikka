import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[
            Container(
              decoration: const BoxDecoration(
              color: AppColors.blueThemeColor
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height *.01,) ,
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
                    SizedBox(height: Get.height*0.02,),
                     Column(
                      children: [
                        Stack(
                            children: [
                               CircleAvatar(
                                radius: 40,
                                // backgroundImage: NetworkImage( widget.recruiterData?.profileImg ?? ''),
                                 child: CachedNetworkImage(
                                   imageUrl: widget.recruiterData?.profileImg ?? '',
                                   imageBuilder: (context, imageProvider) => Container(
                                     decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       image: DecorationImage(
                                         image: imageProvider,
                                         fit: BoxFit.cover
                                       )
                                     ),
                                   ),
                                   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                 ),
                              ),
                            ]
                        )
                      ],
                    ),
                    SizedBox(height: Get.height*0.01,),
                    HtmlWidget(widget.recruiterData?.fullname ?? "",textStyle: Get.theme.textTheme.displayLarge),
                    // Text( CommonFunctions.parseHTML(widget.recruiterData?.fullname ?? ""),style: Get.theme.textTheme.displayLarge),
                    SizedBox(height: Get.height*0.005,),
                    Text( widget.recruiterData?.seekerData?.positions ?? "",style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
                    SizedBox(height: Get.height*0.005,),
                    HtmlWidget(widget.recruiterData?.location ?? "",textStyle: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
                    SizedBox(height: Get.height*0.01,),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.white ),
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
                      ],
                    ),
                    SizedBox(height: Get.height*0.02,),
                    widget.recruiterData?.seekerData?.startWorkName?[0].startWork == null ||
                    widget.recruiterData?.seekerData?.startWorkName?[0].startWork.toString().length == 0 ?
                        const SizedBox() :
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
                        widget.recruiterData?.seekerData?.startWorkName?[0].startWork ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,),
                      ),),
                    )
                  ],
                ),
              ),
            ),
            //************** scrollable functionality *******************
            DraggableScrollableSheet(
              initialChildSize: 0.42, // half screen
              minChildSize: 0.42, // half screen
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
                                        child: Image.asset('assets/images/about.png',height: Get.height*.03,)),
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
                                HtmlWidget(widget.recruiterData?.aboutMe ?? "No Data",textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                                // Text( CommonFunctions.parseHTML(widget.recruiterData?.aboutMe ?? "No Data") ,
                                //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),

                                //********************* for work ex ***************************
                                SizedBox(height: Get.height*0.025,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        child: Image.asset('assets/images/icon work experience.png',height: Get.height*.03,)),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        HtmlWidget(data?.workExpJob ?? "",textStyle: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        // Text(CommonFunctions.parseHTML(data?.workExpJob ?? ""),style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(height: Get.height*0.001,),
                                        HtmlWidget(data?.companyName ?? "",textStyle: Theme.of(context).textTheme.bodySmall!
                                            .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),),
                                        // Text( CommonFunctions.parseHTML(data?.companyName ?? ""),style: Theme.of(context).textTheme.bodySmall!
                                        //     .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        // ),
                                        Text( "${data?.jobStartDate?.year}-${data?.jobStartDate?.month}-${data?.jobStartDate?.day} - ${data?.jobEndDate}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height*.01,)
                                      ],
                                    );
                                  }
                                ),

                                //********************* for Education ***************************
                                SizedBox(height: Get.height*0.02,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: Image.asset('assets/images/icon education.png',height: Get.height*.037,)),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data?.educationLevel ?? "",style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(height: Get.height*0.001,),
                                        Text(data?.institutionName ?? "",style: Theme.of(context)
                                            .textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                        Text( "${data?.educationStartDate?.year}-${data?.educationStartDate?.month}-${data?.educationStartDate?.day} - ${data?.educationEndDate}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height*.01,)
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
                                            child: Image.asset('assets/images/skillsvg.png',height: Get.height*.03,)),
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
                                // SizedBox(height: Get.height*0.04,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       children: [
                                //         InkWell(
                                //             child: Image.asset('assets/images/appreciation.png',height: Get.height*.03,)),
                                //         SizedBox(width: Get.width*0.02,),
                                //         Padding(
                                //           padding: const EdgeInsets.only(top: 2.0),
                                //           child:
                                //           Text('Language',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: Get.height*0.02,),
                                // const Divider(thickness: 0.2,color: AppColors.white,),
                                SizedBox(height: Get.height*0.03,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            child: SvgPicture.asset('assets/images/language.svg',height: Get.height*.03,)),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data?.achievement ?? "",style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(height: Get.height*0.001,),
                                        Text(data?.awardName ?? "",style: Theme.of(context).textTheme.bodySmall!
                                            .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
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
                                      const SizedBox(width: 20), // Adding spacing between buttons
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


