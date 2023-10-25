
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/res/components/request_timeout_widget.dart';
import 'package:flikka/res/components/server_error_widget.dart';
import 'package:flikka/res/components/unauthorised_request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
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


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  List<String> cards = [
    'assets/images/swiperbg.png', 'assets/images/swiperbg.png',
  ];

  GetJobsListingController getJobsListingController = GetJobsListingController() ;
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  @override
  void initState() {
    getJobsListingController.seekerGetAllJobsApi() ;
    seekerProfileController.viewSeekerProfileApi() ;
    super.initState();
  }

  List? rejected = [];
  List? approved = [];

  var last = false ;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (getJobsListingController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (getJobsListingController
              .error.value ==
              'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {},
            ),);
          } else if (getJobsListingController
          .error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {}),);
          } else if (getJobsListingController
              .error.value == "Internal server error") {
            return Scaffold(body: ServerErrorWidget(onPress: () {}),);
          } else if (getJobsListingController.
          error.value == "Unauthorised Request") {
            return Scaffold(body: UnauthorisedRequestWidget(onPress: () {}),);
          }else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {}),);
          }
        case Status.COMPLETED:
          return Scaffold(
          endDrawer: DrawerClass(
            name: '${seekerProfileController.viewSeekerData.value.seekerInfo?.fullname}',
            location: '${seekerProfileController.viewSeekerData.value.seekerInfo?.location}',
            jobTitle: '${seekerProfileController.viewSeekerData.value.seekerDetails?.positions}',
          profileImage: '${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}',),
          body: SafeArea(
            child:
              Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Image.asset('assets/images/icon_flikka_logo.png',height: Get.height*.05, fit: BoxFit.contain),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height*.03,),
                        Text(
                          "Find Job",
                          style:Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                            "California USA",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF))
                        )
                      ],
                    ),
                    Builder(
                        builder: (context) {
                          return InkWell(
                              onTap: ()=> Scaffold.of(context).openEndDrawer(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Image.asset('assets/images/inactive.png'),
                              ));
                        }
                    ),
                  ],
                ),
                Flexible(
                  child:
                  last ? const SeekerNoJobAvailable() :
                  CardSwiper(
                    controller: controller,
                    cardsCount: getJobsListingController.getJobsListing.value.jobs?.length ?? 0 ,
                    numberOfCardsDisplayed: 2,
                    isLoop: false,
                    backCardOffset: const Offset(40, 40),
                    padding: const EdgeInsets.all(24.0),
                    onEnd: () {setState(() {
                      last = true ;
                    });
                    },
                    allowedSwipeDirection: AllowedSwipeDirection.only(left: true,right: true),
                    onSwipe: _onSwipe,
                    cardBuilder: (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                        ) {
                      debugPrint(getJobsListingController.getJobsListing.value.jobs?.length.toString()) ;
                      return  HomeSwiperWidget(jobData: getJobsListingController.getJobsListing.value.jobs?[index],);
                    },
                  ),
                ),

              ],
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
    if(direction.name == "left") {
      print("swiped left") ;
      // setState(() {
        rejected?.add(currentIndex) ;
        print("this is rejected list $rejected") ;
      // });

    } else if (direction.name == "right") {
      approved?.add(currentIndex) ;
      print("this is approved list $approved") ;
    }
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }


}
