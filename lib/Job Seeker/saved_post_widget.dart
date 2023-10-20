import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/app_colors.dart';
import 'SeekerHome/home_swiper_find_job_widget.dart';

class SavedPost extends StatefulWidget {
  const SavedPost({super.key});

  @override
  State<SavedPost> createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
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
            style: TextStyle(
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
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
              child: Image.asset('assets/images/backicon.png')),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text("Saved Post",style: Get.theme.textTheme.displayLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15,top: 20),
            child: Text("Delete All",style: Get.theme.textTheme.bodyLarge!.copyWith(color: Colors.blue)),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
        return
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
            Container(
              decoration: BoxDecoration(
                  color: AppColors.blackdown,
                  borderRadius: BorderRadius.circular(34)
              ),
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  //*************** for swiper image **************
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26)
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
                  //*************** for 50% match **************
                  Positioned(
                    right: 20,
                    top: 10,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: AppColors.white, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment
                                        .topCenter, // Start from the top center
                                    end: Alignment
                                        .bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: CircleAvatar(
                                    radius: 30,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text('50%',
                                              style: Get.theme.textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:
                                                  AppColors.white)),
                                          Text('match',
                                              style: Get.theme.textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:
                                                  AppColors.white,
                                                  fontSize: 7)),
                                        ],
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent)),
                          ),
                        )
                      ],
                    ),
                  ),
                  //*************** for bookmarks **************
                  Positioned(
                    left: 12,
                    top: 15,
                    child: Stack(
                      children: [
                        Image.asset("assets/images/icon_Save_post.png",height: Get.height*.043,),
                      ],
                    ),
                  ),
                  //*************** for marketing intern text  **************
                  Positioned(
                    //height: Get.height / 2.5-Get.height*0.12 ,
                    bottom: Get.height*0.09,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(20),
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
                            height: Get.height * .005,
                          ),
                          Text(
                            "Example Company Pvt. Ltd",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                color: AppColors
                                    .ratingcommenttextcolor),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Text(
                            "Job Description",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(
                            height: Get.height * .005,
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                color: AppColors
                                    .ratingcommenttextcolor),
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
                          Text(
                            "• Sed ut perspiciatis unde omnis iste natus error sit.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                color: AppColors
                                    .ratingcommenttextcolor),
                          )
                        ],
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
                                      'assets/images/likesvg.svg',width: Get.width*0.027,height: Get.height*0.027,
                                      color: buttonColor,
                                    )
                                        : Icon(
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
                                  icon: SvgPicture.asset('assets/images/commentsvg.svg'),
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
                                  Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Color(0xff56B8F6),
                                          radius: 17,
                                          child: Image.asset(
                                            'assets/images/personicons.png',
                                          ),
                                          // Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor,)
                                        ),
                                        SvgPicture.asset('assets/images/personsvg22.svg')
                                      ]
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
            )
          );

          }),
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
