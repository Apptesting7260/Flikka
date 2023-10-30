import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/SeekerSavedJobsController/SeekerSavedJobsListController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../data/response/status.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
import '../res/components/request_timeout_widget.dart';
import '../res/components/server_error_widget.dart';
import '../res/components/unauthorised_request_widget.dart';
import '../widgets/app_colors.dart';

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

  SeekerSavedJobsListController jobsListController = Get.put(SeekerSavedJobsListController()) ;

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

  @override
  void initState() {
   jobsListController.savePostApi("1") ;
    super.initState();
  }

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (jobsListController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (jobsListController.error.value == 'No internet') {
            return Scaffold(body: InterNetExceptionWidget(onPress: () {},),);
          } else if (jobsListController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {}),);
          } else
          if (jobsListController.error.value == "Internal server error") {
            return Scaffold(body: ServerErrorWidget(onPress: () {}),);
          } else if (jobsListController.error.value == "Unauthorised Request") {
            return Scaffold(body: UnauthorisedRequestWidget(onPress: () {}),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {}),);
          }
        case Status.COMPLETED:
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset('assets/images/icon_back_blue.png')),
              ),
              elevation: 0,
              backgroundColor: Colors.black,
              title: Text("Saved Post", style: Get.theme.textTheme.displayLarge),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 20),
                  child: Text("Delete All",
                      style: Get.theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.blue)),
                )
              ],
            ),
            body: ListView.builder(
                itemCount: jobsListController.savedPosts.value.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  var data = jobsListController.savedPosts.value.data?[index] ;
                  return Padding( padding: const EdgeInsets.all(18.0),
                        child:
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.blackdown,
                              borderRadius: BorderRadius.circular(34)),
                          height: Get.height,
                          width: Get.width,
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: Get.width,
                                placeholder: (context, url) => const Center(child:CircularProgressIndicator()),
                                imageUrl:  "${data?.jobData?.featureImg}" ,),
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
                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                            child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.transparent,
                                                child: Center(
                                                  child: Column( mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('50%',
                                                          style: Get.theme.textTheme.bodySmall!.copyWith(
                                                              color: AppColors.white)),
                                                      Text('match',
                                                          style: Get.theme.textTheme.bodySmall!.copyWith(
                                                              color: AppColors.white, fontSize: 7)),
                                                    ],
                                                  ),
                                                ))),
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
                                    Image.asset("assets/images/icon_Save_post.png", height: Get.height * .043,),
                                  ],
                                ),
                              ),
                              //*************** for marketing intern text  **************
                              Positioned(
                                //height: Get.height / 2.5-Get.height*0.12 ,
                                bottom: Get.height * 0.09,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: AppColors.blackdown,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(22),
                                        topRight: Radius.circular(22)),
                                  ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data?.jobData?.jobPositions ?? "Test Data",
                                        style: Theme.of(context).textTheme.displayLarge,
                                        softWrap: true,),
                                      SizedBox( height: Get.height * .005,),
                                      Text(data?.jobData?.recruiterDetails?.companyName ?? "Test Data",
                                        style: Theme.of(context).textTheme.bodySmall!
                                            .copyWith( color: AppColors.ratingcommenttextcolor),),
                                      SizedBox( height: Get.height * 0.03,),
                                      Text( "Job Description",
                                        style: Theme.of(context).textTheme.titleSmall!
                                            .copyWith(color: AppColors.white),),
                                      SizedBox( height: Get.height * .005,),
                                      Text( data?.jobData?.description ?? "Test Data" ,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: Theme.of(context).textTheme.bodySmall!
                                            .copyWith( color: AppColors.ratingcommenttextcolor),),
                                      SizedBox( height: Get.height * 0.03,),
                                      Text( "Requirements",
                                        style: Theme.of(context).textTheme.titleSmall!
                                            .copyWith(color: AppColors.white),),
                                      SizedBox( height: Get.height * 0.015,),
                                      Text( data?.jobData?.requirements ?? "Test Data",
                                        style: Theme.of(context).textTheme.bodySmall!
                                            .copyWith(color: AppColors.ratingcommenttextcolor),)
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
                                                onPressed: () =>
                                                    toggleFavorite(),
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
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 14)),
                                            SizedBox(
                                              width: Get.width * 0.04,
                                            ),

                                            //*************************

                                            IconButton(
                                              onPressed: () {
                                                showCommentDialog();
                                              },
                                              icon: SvgPicture.asset(
                                                  'assets/images/commentsvg.svg'),
                                            ),
                                            Text("10",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 14.0),
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
                                                    SvgPicture.asset(
                                                        'assets/images/personsvg22.svg')
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
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                      color: AppColors.white,
                                                      fontSize: 14)),
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
    }
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
