import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/Job%20Seeker/SeekerForum/add_new_forum.dart';
import 'package:flikka/controllers/SeekerForumController/ForumIndustryListController.dart';
import 'package:flikka/controllers/SeekerForumController/SeekerForumDataController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import 'forum_only_comment_page.dart';

class ForumFirstPage extends StatefulWidget {
  const ForumFirstPage({super.key});

  @override
  State<ForumFirstPage> createState() => _ForumFirstPageState();
}

class _ForumFirstPageState extends State<ForumFirstPage> {

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
     forumDataController.seekerForumListApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
     forumDataController.seekerForumListApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  SeekerForumDataController forumDataController = Get.put(SeekerForumDataController()) ;
  SeekerForumIndustryController industryController = Get.put(SeekerForumIndustryController()) ;

  String? industryID ;

  @override
  void initState() {
    forumDataController.seekerForumListApi() ;
    industryController.industryApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (forumDataController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (forumDataController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  forumDataController.seekerForumListApi();
                },
              ),);
          } else if (forumDataController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              forumDataController.seekerForumListApi();
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              forumDataController.seekerForumListApi();
            }),);
          }
        case Status.COMPLETED:
          return Obx(() {
            switch (industryController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),);
              case Status.ERROR:
                if (industryController.error.value ==
                    'No internet') {
                  return Scaffold(
                    body: InterNetExceptionWidget(
                      onPress: () {
                        industryController.industryApi();
                      },
                    ),);
                } else
                if (industryController.error.value == 'Request Time out') {
                  return Scaffold(body: RequestTimeoutWidget(onPress: () {
                    industryController.industryApi();
                  }),);
                } else {
                  return Scaffold(body: GeneralExceptionWidget(onPress: () {
                    industryController.industryApi();
                  }),);
                }
              case Status.COMPLETED:
                return SafeArea(
                  child: Scaffold(
                    body: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * .01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Get.offAll(const TabScreen(index: 0));
                                          },
                                          child: Image.asset(
                                            "assets/images/icon_back_blue.png",
                                            height: Get.height * .055,)),
                                      SizedBox(width: Get.width * .04,),
                                      Text("Forum",
                                          style: Get.theme.textTheme.displayLarge),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * .02,),
                              industryController.industryData.value.industryList == null ||
                              industryController.industryData.value.industryList?.length == 0 ?
                                  const SizedBox() :
                              SizedBox(
                                height: Get.height * .15,
                                child: ListView.builder(shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: industryController.industryData.value.industryList?.length,
                                    itemBuilder: (BuildContext context, int index) {
                                  var data = industryController.industryData.value.industryList?[index] ;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox( width: Get.width * 0.22,
                                          child: GestureDetector(
                                            onTap: () {
                                              industryID = data?.id.toString() ;
                                              forumDataController.seekerForumListApi(industryID: industryID);
                                            },
                                            child: Column(
                                              children: [
                                               CachedNetworkImage(imageUrl: data?.industryImg ?? "" ,
                                               placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                                 imageBuilder: (context, imageProvider) => Container(
                                                   height: 60,
                                                   width: 60,
                                                   decoration: BoxDecoration(
                                                     shape: BoxShape.circle ,
                                                     image: DecorationImage(image: imageProvider)
                                                   ),
                                                 ),
                                               ) ,
                                                SizedBox(height: Get.height * .01,),
                                                Text(data?.industryPreferences ?? "", overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.bodyMedium
                                                    ?.copyWith(fontWeight: FontWeight.w700 ,
                                                  color: forumDataController.industryId.value == data?.id.toString() ?
                                                  AppColors.blueThemeColor : AppColors.white),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(height: Get.height * .01,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * .05,
                                          vertical: Get.height * .002),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff373737),
                                        borderRadius: BorderRadius.circular(33.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.search, color: AppColors.blueThemeColor,
                                            size: 30,),
                                          SizedBox(width: Get.width * .03),
                                          Expanded(
                                            child: TextFormField(
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: const Color(0xffCFCFCF), fontSize: 19),
                                              onChanged: (query) {
                                                forumDataController.filterList(query) ;
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Search',
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                    color: Color(0xffCFCFCF)),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.015,
                                  ),
                                  Container(
                                      height: Get.height * 0.06,
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => AddNewForum(list: industryController.industryData.value.industryList ,));
                                          },
                                          child: Image.asset('assets/images/icon_add_form.png',
                                            fit: BoxFit.cover,))),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              //************* list *((((((((((((((((((((((((((((((((

                              forumDataController.forumData.value.forumData == null ||
                              forumDataController.forumData.value.forumData?.length == 0 ?
                                  Text("No Data") :
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: forumDataController.forumList?.reversed.length,
                                  itemBuilder: (context, index) {
                                    var data = forumDataController.forumList?[index];
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * .02),
                                      child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => ForumOnlyCommentPage(forumData: data,industryID: industryID,));
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(left: 7.0, top: 15),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff353535),
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      22),
                                                ),
                                                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  //crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    CachedNetworkImage(imageUrl: data?.seekerImg ?? "" ,
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle ,
                                                            image: DecorationImage(image: imageProvider)
                                                        ),
                                                      ),
                                                    ) ,
                                                    SizedBox(width: Get.width * 0.035,),
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 8),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox( width : Get.width * 0.5,
                                                                child: Text(
                                                                  data?.industryPreference ?? "",
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: Theme.of(context).textTheme.titleSmall!
                                                                      .copyWith(color: AppColors.blueThemeColor),
                                                                  softWrap: true,),
                                                              ),
                                                              SizedBox(height: Get.height * 0.005,),
                                                              SizedBox( width : Get.width * 0.5,

                                                                child: Text(
                                                                  data?.title ?? "",
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                                      .copyWith(color: AppColors.white),
                                                                  softWrap: true,),
                                                              ),
                                                              SizedBox(height: Get.height * 0.005,),
                                                              Text(data?.seekerName ?? "",
                                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                    color: AppColors.ratingcommenttextcolor),),
                                                              SizedBox(height: Get.height * 0.01,),
                                                              SizedBox(width: Get.width * 0.60,
                                                                child:HtmlWidget( data?.titleDescription ?? "",textStyle:  Theme
                                                                    .of(context).textTheme.bodySmall!.copyWith(
                                                                    color: AppColors.ratingcommenttextcolor, letterSpacing: 0.01),),
                                                                // Text(
                                                                //   data?.titleDescription ?? "",
                                                                //   textAlign: TextAlign
                                                                //       .justify,
                                                                //   style: Theme
                                                                //       .of(
                                                                //       context)
                                                                //       .textTheme
                                                                //       .bodySmall!
                                                                //       .copyWith(
                                                                //       color: AppColors
                                                                //           .ratingcommenttextcolor,
                                                                //       letterSpacing: 0.01
                                                                //   ),
                                                                // ),
                                                              ),
                                                              SizedBox(height: Get.height * 0.15,),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight: Radius
                                                          .circular(25),
                                                      bottomLeft: Radius.circular(
                                                          25)),
                                                  color: Color(0xff3F3F3F),
                                                ),
                                                height: 70,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 18.0),
                                                    child: Row(
                                                      children: [
                                                        Image.asset('assets/images/viewicon.png', scale: 0.7,),
                                                        SizedBox(width: Get.width * 0.015,),
                                                        Text("${data?.forumViewCount} Views",
                                                          style: Get.theme.textTheme.bodySmall!
                                                              .copyWith(color: AppColors.white),),
                                                        SizedBox(width: Get.width * 0.075,),
                                                        GestureDetector(
                                                          onTap : () {
                                                            Get.to(() => ForumOnlyCommentPage(forumData: data,industryID: industryID,));} ,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  'assets/images/commenticons.png'),
                                                              SizedBox(
                                                                width: Get.width *
                                                                    0.015,),
                                                              Text("${data?.forumCommentCount} Comments",
                                                                style: Get.theme.textTheme.bodySmall!
                                                                    .copyWith(color: AppColors.white),),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
            }
          }
          );
      }
    }
    );
  }
}
