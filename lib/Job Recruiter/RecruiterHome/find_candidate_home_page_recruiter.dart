import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/view_candidate_profile.dart';
import 'package:flikka/models/RecruiterHomePageModel/RecruiterHomePageModel.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/RecruiterHomeModel/RecruiterHomeModel.dart';

class FindCandidateHomePageRecruiter extends StatefulWidget {
  final RecruiterHomePageSeekerDetail? recruiterData ;
  const FindCandidateHomePageRecruiter({super.key, this.recruiterData});

  @override
  State<FindCandidateHomePageRecruiter> createState() => _FindCandidateHomePageRecruiterState();
}

class _FindCandidateHomePageRecruiterState extends State<FindCandidateHomePageRecruiter> {

  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  bool selectedFav = false;
  Color buttonColor = AppColors.ratingcommenttextcolor;

  void toggleFavorite() {
    setState(() {
      selectedFav = !selectedFav;
      buttonColor =
      selectedFav ? AppColors.red : AppColors.ratingcommenttextcolor;
    });
  }

  TextEditingController commentController = TextEditingController();
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add a Comment",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.blackdown, borderRadius: BorderRadius.circular(34)),
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          //************* for swiper image ************
          GestureDetector(
            onTap: () {
            Get.to(() => ViewCandidateProfile( recruiterData: widget.recruiterData, )) ;
            },
            child: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(26)),
              width: Get.width,
              height: Get.height * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: "${widget.recruiterData?.seeker?.profileImg}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                ),
                // child: Image.network(
                //   widget.recruiterData?.profileImg ?? "",
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          //************* for 50% match ************
          // Positioned(
          //   right: 20,
          //   top: 10,
          //   child: Stack(
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             border: Border.all(color: AppColors.white, width: 2)),
          //         child: Padding(
          //           padding: const EdgeInsets.all(3.0),
          //           child: Container(
          //               decoration: const BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: AppColors.blueThemeColor
          //               ),
          //               child: CircleAvatar(
          //                   radius: 30,
          //                   backgroundColor: Colors.transparent,
          //                   child: Center(
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text('50%',
          //                             style: Get.theme.textTheme.bodySmall!
          //                                 .copyWith(color: AppColors.white)),
          //                         Text('match',
          //                             style: Get.theme.textTheme.bodySmall!
          //                                 .copyWith(
          //                                 color: AppColors.white,
          //                                 fontSize: 7)),
          //                       ],
          //                     ),
          //                   ))),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //************* for bookmarks ************
          // Positioned(
          //   left: 12,
          //   top: 15,
          //   child: Column(
          //     children: [
          //       Image.asset("assets/images/icon_Save_post.png",height: Get.height*.043,),
          //       SizedBox(
          //         height: Get.height * .01,
          //       ),
          //       Image.asset(
          //         "assets/images/icon_filter_seeker_home.png",
          //         height: Get.height * .043,
          //       ),
          //     ],
          //   ),
          // ),
          //************* for marketing intern text  ************
          Positioned(
            height: Get.height / 2.5-Get.height*0.12 ,
            bottom: Get.height * 0.05,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xff353535),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(widget.recruiterData?.seeker?.fullname ?? "" ,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge,
                            softWrap: true,
                          ),
                        ),
                        const Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 26,),
                      ],
                    ),
                    Text( widget.recruiterData?.positions ?? "",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,),),
                    SizedBox(height: Get.height * 0.010,),
                    Text(widget.recruiterData?.seeker?.location ?? "",overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                 Row(
                   children: [
                     Image.asset("assets/images/icon work experience.png",height: 18,color: AppColors.blueThemeColor,),
                     SizedBox(width: Get.width*.03,),
                     Text("Work experience",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),)
                   ],
                 ),
                    SizedBox(height: Get.height*.004,),
                    widget.recruiterData?.workExpJob?.length == 0 ||
                        widget.recruiterData?.workExpJob == null ?
                        const SizedBox() :
                    ListView.builder(
                      itemCount: widget.recruiterData?.workExpJob?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context , index) {
                        var data = widget.recruiterData?.workExpJob?[index] ;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( data?.workExpJob ?? "",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xffCFCFCF)),
                              ),
                              Text( data?.companyName ?? "",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xffCFCFCF)),
                              ),
                              Text("${data?.jobStartDate.toString().replaceAll("00:00:00.000", "")}- ${data?.jobEndDate.toString().replaceAll("00:00:00.000", "")}",
                                // "${data?.jobStartDate?.year.toString().padLeft(4,'0')}-${data?.jobStartDate?.month.toString().padLeft(2,'0')}-${data?.jobStartDate?.day.toString().padLeft(2,'0')} - ${data?.jobEndDate}" ,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xffCFCFCF)),
                              ),
                            ],
                          ) ;

                    }) ,
                    SizedBox(height: Get.height * 0.03,),
                    Row(
                      children: [
                        Image.asset("assets/images/icon_education.png",height: 30,color: AppColors.blueThemeColor,),
                        SizedBox(width: Get.width*.03,),
                        Text("Education",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),)
                      ],
                    ),
                    SizedBox(height: Get.height*.004,),
                    widget.recruiterData?.educationLevel?.length == 0 ||
                        widget.recruiterData?.educationLevel == null ?
                        const SizedBox() :
                    ListView.builder(
                      shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.recruiterData?.educationLevel?.length,
                        itemBuilder: (context , index) {
                        var data = widget.recruiterData?.educationLevel?[index] ;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( data?.educationLevel ?? "",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xffCFCFCF)),
                          ),
                          Text( data?.institutionName ?? "",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xffCFCFCF)),
                          ),
                          Text( "${data?.educationStartDate.toString().replaceAll("00:00:00.000", "")} - ${data?.educationEndDate.toString().replaceAll("00:00:00.000", "")}",
                            // "${data?.educationStartDate?.year}-${data?.educationStartDate?.month.toString().padLeft(2,'0')}-${data?.educationStartDate?.day.toString().padLeft(2,'0')} - ${data?.educationEndDate}"  ,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xffCFCFCF)),
                          ),
                        ],
                      ) ;
                    }) ,
                    SizedBox(height: Get.height*.03,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff3F3F3F),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(22)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => toggleFavorite(),
                            icon: selectedFav == false
                                ? SvgPicture.asset(
                              'assets/images/likesvg.svg',
                              width: Get.width * 0.027,
                              height: Get.height * 0.027,
                            )
                                : const Icon(
                              Icons.favorite_rounded,
                              color: AppColors.red,
                            )),
                        Text("12",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                color: AppColors.white, fontSize: 14)),
                        SizedBox(
                          width: Get.width * 0.04,
                        ),

                        //*************************

                        IconButton(
                          onPressed: () {
                            showCommentDialog();
                          },
                          icon:
                          SvgPicture.asset('assets/images/commentsvg.svg'),
                        ),
                        Text("10",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                color: AppColors.white, fontSize: 14)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: text.isEmpty &&
                                imagePaths.isEmpty &&
                                uri.isEmpty
                                ? null
                                : () => _onShare(context),
                            icon: SvgPicture.asset('assets/images/sharesvg.svg',),),
                          Text("2",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                  color: AppColors.white, fontSize: 14)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (uri.isNotEmpty) {
      await Share.shareUri(Uri.parse(uri));
    } else if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      await Share.shareXFiles(files,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}
