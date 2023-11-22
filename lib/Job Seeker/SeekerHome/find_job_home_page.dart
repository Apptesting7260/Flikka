import 'package:flikka/controllers/SeekerJobFilterController/SeekerJobFilterController.dart';
import 'package:flikka/controllers/SeekerSavedJobsController/SeekerSavedJobsController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/res/components/request_timeout_widget.dart';
import 'package:flikka/res/components/server_error_widget.dart';
import 'package:flikka/res/components/unauthorised_request_widget.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import 'home_swiper_find_job_widget.dart';
import '../SeekerDrawer/Drawer_page.dart';
import '../SeekerJobs/no_job_available.dart';
import 'package:get/get.dart';

class FindJobHomeScreen extends StatefulWidget {
  const FindJobHomeScreen({super.key});

  @override
  State<FindJobHomeScreen> createState() => _FindJobHomeScreenState();
}

class _FindJobHomeScreenState extends State<FindJobHomeScreen> {
  final CardSwiperController controller = CardSwiperController();

  List<CardSwiperDirection> allDirections = CardSwiperDirection.values;


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  List<String> cards = [
    'assets/images/icon_view_recruiter_job_background.png', 'assets/images/icon_view_recruiter_job_background.png',
  ];

  GetJobsListingController getJobsListingController = GetJobsListingController() ;
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;
  SeekerSaveJobController seekerSaveJobController = Get.put(SeekerSaveJobController()) ;
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  SeekerJobFilterController jobFilterController = Get.put(SeekerJobFilterController()) ;

  @override
  void initState() {
    getJobsListingController.seekerGetAllJobsApi() ;
    seekerProfileController.viewSeekerProfileApi() ;
    super.initState();
  }

  List? rejected = [];
  List? approved = [];
  List? saved = [];

  var last = false ;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (getJobsListingController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (getJobsListingController.error.value == 'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {
                getJobsListingController.seekerGetAllJobsApi() ;
                seekerProfileController.viewSeekerProfileApi() ;
              },
            ),);
          } else if (getJobsListingController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              getJobsListingController.seekerGetAllJobsApi() ;
              seekerProfileController.viewSeekerProfileApi() ;
            }),);
          } else if (getJobsListingController.error.value == "Internal server error") {
            return Scaffold(body: ServerErrorWidget(onPress: () {}),);
          } else if (getJobsListingController.error.value == "Unauthorised Request") {
            return Scaffold(body: UnauthorisedRequestWidget(onPress: () {}),);
          }else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              getJobsListingController.seekerGetAllJobsApi() ;
              seekerProfileController.viewSeekerProfileApi() ;
            }),);
          }
        case Status.COMPLETED:
          return Scaffold(
           endDrawer: DrawerClass(
            name: '${seekerProfileController.viewSeekerData.value.seekerInfo?.fullname}',
            location: '${seekerProfileController.viewSeekerData.value.seekerInfo?.location}',
            jobTitle: '${seekerProfileController.viewSeekerData.value.seekerDetails?.positions ?? ''}',
          profileImage: '${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}',),
           body: SafeArea(
            child:
              GestureDetector(
                onTap: () {
                  if (Scaffold.of(context).isEndDrawerOpen) {
                    Navigator.of(context).pop();
                  }
                },
                child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Image.asset('assets/images/icon_flikka_logo.png',height: Get.height*.032, ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height*.03,),
                          Text(
                            "Find Job",
                            style:Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                              seekerProfileController.viewSeekerData.value.seekerInfo?.location ?? "No Data",
                             overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.graySilverColor)
                          )
                        ],
                      ),
                      Builder(
                          builder: (context) {
                            return InkWell(
                                onTap: ()=> Scaffold.of(context).openEndDrawer(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Image.asset('assets/images/inactive.png',height: Get.height*.05,),
                                ));
                          }
                      ),
                    ],
                  ),
                  Flexible(
                    child:
                    last ? const SeekerNoJobAvailable() :
                    getJobsListingController.getJobsListing.value.jobs?.length == 0 ||
                        getJobsListingController.getJobsListing.value.jobs == null ?
                    const SeekerNoJobAvailable() :  Obx( () =>
                    jobFilterController.reset.value ?
                    CardSwiper(
                        controller: controller,
                        cardsCount: getJobsListingController.getJobsListing.value.jobs?.length ?? 0 ,
                        numberOfCardsDisplayed: getJobsListingController.getJobsListing.value.jobs!.length >= 2 ? 2 : 1,
                        // isLoop: false,
                        backCardOffset: const Offset(40, 40),
                        padding: const EdgeInsets.all(24.0),
                        allowedSwipeDirection: AllowedSwipeDirection.only(left: true,right: true , up : true),
                        onSwipe: _onSwipe,
                        // onEnd: () {
                        //   for (var direction in allDirections) {
                        //     _onSwipe(null, getJobsListingController.getJobsListing.value.jobs!.length - 1, direction);
                        //     Timer(const Duration(milliseconds: 300), () {
                        //       setState(() {
                        //         last = true;
                        //       });
                        //     });
                        //   }
                        // },
                        cardBuilder: (context, index,
                            horizontalThresholdPercentage, verticalThresholdPercentage,) {
                          debugPrint(getJobsListingController.getJobsListing.value.jobs?.length.toString()) ;
                          return  HomeSwiperWidget(jobData: getJobsListingController.getJobsListing.value.jobs?[index],);

                        },
                      )
                      : jobFilterController.jobsData.value.jobs?.length == 0 ||
                        jobFilterController.jobsData.value.jobs == null ?
                    const SeekerNoJobAvailable() : CardSwiper(
                      controller: controller,
                      cardsCount: jobFilterController.jobsData.value.jobs?.length ?? 0 ,
                      numberOfCardsDisplayed: jobFilterController.jobsData.value.jobs?.length == 1 ? 1 : 2,
                      // isLoop: false,
                      backCardOffset: const Offset(40, 40),
                      padding: const EdgeInsets.all(24.0),
                      allowedSwipeDirection: AllowedSwipeDirection.only(left: true,right: true , up : true),
                      onSwipe: _onSwipe,
                      // onEnd: () {
                      //   for (var direction in allDirections) {
                      //     _onSwipe(null, getJobsListingController.getJobsListing.value.jobs!.length - 1, direction);
                      //     Timer(const Duration(milliseconds: 300), () {
                      //       setState(() {
                      //         last = true;
                      //       });
                      //     });
                      //   }
                      // },
                      cardBuilder: (context, index,
                          horizontalThresholdPercentage, verticalThresholdPercentage,) {
                        debugPrint("inside filter jobs") ;
                        debugPrint(jobFilterController.jobsData.value.jobs?.length.toString()) ;
                        return  HomeSwiperWidget(jobData: jobFilterController.jobsData.value.jobs?[index],);

                      },
                    ),
                    ),
                  ),

                ],
            ),
              ),
          ),
        );
      }
   }
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    if(currentIndex != null ) {
      if (direction.name == "left") {
        print("swiped left");
      } else if (direction.name == "right") {
        CommonFunctions.confirmationDialog(context, message: "Do you want to Apply for the post", onTap: () {
          Get.back() ;
          CommonFunctions.showLoadingDialog(context, "Applying") ;
          applyJobController.applyJob(getJobsListingController.getJobsListing.value.jobs?[previousIndex].id.toString()) ;
        }) ;
        debugPrint("this is approved list $approved");
      } else if (direction.name == "top") {
        CommonFunctions.confirmationDialog(context, message: "Do you want to save the post", onTap: () {
          Get.back() ;
          CommonFunctions.showLoadingDialog(context, "Saving") ;
          seekerSaveJobController.saveJobApi(getJobsListingController.getJobsListing.value.jobs?[previousIndex].id , 1) ;
        }) ;

        print("this is saved list $saved");
      }
      debugPrint(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
      );
    }
      return true;

  }
  // lastCard(CardSwiperDirection direction) {
  //   _onSwipe(null, getJobsListingController.getJobsListing.value.jobs!.length - 1, direction) ;
  // }

}
