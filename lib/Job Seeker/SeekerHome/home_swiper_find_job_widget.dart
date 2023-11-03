import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/SeekerFilter/filter_page.dart';
import 'package:flikka/Job%20Seeker/marketing_page.dart';
import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../widgets/my_button.dart';

class HomeSwiperWidget extends StatefulWidget {
 final SeekerJobsData? jobData ;
  const HomeSwiperWidget({super.key , required this.jobData});

  @override
  State<HomeSwiperWidget> createState() => _HomeSwiperWidgetState();
}

class _HomeSwiperWidgetState extends State<HomeSwiperWidget> {
  bool _isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

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
    var data = widget.jobData ;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.blackdown, borderRadius: BorderRadius.circular(34)),
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          //************* for swiper image ************
          GestureDetector(
            onTap: () {
              Get.to(() =>  MarketingIntern( jobData: widget.jobData, ));
            },
            child: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(26)),
              width: Get.width,
              height: Get.height * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator()),
                    imageUrl: "${data?.featureImg}")
                // Image.network("${data?.featureImg}",
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          //************* for 50% match ************
          Positioned(
            right: 20,
            top: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.white, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueThemeColor
                        ),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('50%',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(color: AppColors.white)),
                                  Text('match',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                          color: AppColors.white,
                                          fontSize: 7)),
                                ],
                              ),
                            ))),
                  ),
                )
              ],
            ),
          ),
          //************* for bookmarks ************

          Positioned(
            left: 12,
            top: 15,
            child: Column(
              children: [
                Image.asset("assets/images/icon_Save_post.png",height: Get.height*.043,),
                SizedBox(height: Get.height*.01,) ,
                GestureDetector(
                  onTap: () {
                    Get.to(() => FilterPage()) ;
                  },
                    child: Image.asset("assets/images/icon_filter_seeker_home.png",height: Get.height*.043,))
              ],
            ),
          ),

          //************* for marketing intern text  ************
          Positioned(
            //height: Get.height / 2.5-Get.height*0.12 ,
            bottom: Get.height * 0.05,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Get.to(() =>  MarketingIntern( jobData: widget.jobData, ));
              },
              child: Container(
                height: Get.height * 0.35,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.blackdown,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.jobPositions ?? "Test Data",
                        style: Theme.of(context).textTheme.displayLarge,
                        softWrap: true,
                      ),
                      SizedBox(
                        height: Get.height * .003,
                      ),
                      Text(
                        data?.recruiterDetails?.companyName ?? "Test Data",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.ratingcommenttextcolor),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Text(
                        "Job Description",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: Get.height * .008,
                      ),
                      Text(data?.description ?? "Test Data",
                        // overflow: TextOverflow.ellipsis,
                        // softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.ratingcommenttextcolor),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Text(
                        "Requirements",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: Get.height * .007,
                      ),
                      Text(
                        data?.requirements ?? "Test Data",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.ratingcommenttextcolor),
                      ),
                      SizedBox(height: Get.height*.02,),
                    ],
                  ),
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
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.only(
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
                              color: buttonColor,
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
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Stack(children: [
                                    AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17)
                                      ),
                                      //contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Image.asset('assets/images/personpng.png'),
                                            SizedBox(height: Get.height * 0.02),
                                            Text(
                                              "Refer a friend",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                  color: AppColors.white),
                                            ),
                                            SizedBox(height: Get.height * 0.01),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Earn up to ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400),
                                                  ),
                                                  TextSpan(
                                                    text: "£100",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                        color: Colors
                                                            .blue), // Change to the desired blue color
                                                  ),
                                                  TextSpan(
                                                    text:
                                                    " by referring friends.",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.055),
                                            TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                  color: Color(0xff000000),
                                                  fontWeight:
                                                  FontWeight.w600),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                    Get.width * 0.06,
                                                    vertical:
                                                    Get.height * 0.027),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(35),
                                                  borderSide: const BorderSide(
                                                    color: AppColors.blackdown,
                                                  ),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(35),
                                                  borderSide: const BorderSide(
                                                    color: AppColors.blackdown,
                                                  ),
                                                ),
                                                hintText: 'Name',
                                                filled: true,
                                                fillColor: AppColors.white
                                                    .withOpacity(0.1),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                    color:
                                                    Color(0xffCFCFCF),
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              onFieldSubmitted: (value) {},
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your name';
                                                }
                                                return null;
                                              },
                                            ),

                                            SizedBox(
                                                height: Get.height * 0.018),
                                            TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                  color: Color(0xff000000),
                                                  fontWeight:
                                                  FontWeight.w600),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                    Get.width * 0.06,
                                                    vertical:
                                                    Get.height * 0.027),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(35),
                                                  borderSide: const BorderSide(
                                                    color: AppColors.blackdown,
                                                  ),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(35),
                                                  borderSide: const BorderSide(
                                                    color: AppColors.blackdown,
                                                  ),
                                                ),
                                                hintText: 'Email address',
                                                filled: true,
                                                fillColor: AppColors.white
                                                    .withOpacity(0.1),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                    color:
                                                    Color(0xffCFCFCF),
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              onFieldSubmitted: (value) {},
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter an email address';
                                                } else if (!_isValidEmail(
                                                    value)) {
                                                  return 'Please enter a valid email address';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.035),
                                            Center(
                                              child: MyButton(
                                                title: "CONTINUE",
                                                onTap1: () {
                                                  // Get.to(() => LocationPopUp());
                                                },
                                              ),
                                            ),
                                            SizedBox(height: Get.height * 0.02),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //**************** for close on alert dialog **************
                                    Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                            child: Align(
                                              alignment:AlignmentDirectional.topEnd,
                                              child: Container(
                                                height:Get.height * 0.50,
                                                width: Get.width * 0.50,
                                                child: Center(
                                                  child: Stack(
                                                      children: [
                                                        Positioned(
                                                            top: Get.height * 0.135,
                                                            right: Get.width * 0.10,
                                                            child:
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(60.0),
                                                                gradient: const LinearGradient(
                                                                  colors: [
                                                                    Color(0xFF56B8F6),
                                                                    Color(0xFF4D6FED),
                                                                  ],
                                                                  begin: Alignment.topCenter, // Start from the top center
                                                                  end: Alignment.bottomCenter, // End at the bottom center
                                                                ),
                                                              ),
                                                              child: Icon(Icons.close,color: AppColors.white,size: Get.height*0.028,),
                                                            )
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // ******************* for close icon in in *************

                                        ]
                                    )
                                  ]);
                                },
                              );
                            },
                            child: Stack(
                              children: [
                              Image.asset(
                                   'assets/images/personicons.png',height: Get.height*.05,),
                                // CircleAvatar(
                                //   backgroundColor: AppColors.blueThemeColor,
                                //   radius: 17,
                                //   child: Image.asset(
                                //       'assets/images/personicons.png'),
                                // ),

                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: text.isEmpty &&
                                imagePaths.isEmpty &&
                                uri.isEmpty
                                ? null
                                : () => _onShare(context),
                            icon: SvgPicture.asset(
                              'assets/images/sharesvg.svg',
                            ),
                          ),
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
