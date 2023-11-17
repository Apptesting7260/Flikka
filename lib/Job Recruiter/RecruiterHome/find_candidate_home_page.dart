import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page_recruiter.dart';
import 'package:flikka/controllers/RecruiterHomeController/RecruiterHomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import '../../Job Seeker/SeekerJobs/no_job_available.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';


class FindCandidateHomePage extends StatefulWidget {
  const FindCandidateHomePage({super.key});

  @override
  State<FindCandidateHomePage> createState() => _FindCandidateHomePageState();
}

class _FindCandidateHomePageState extends State<FindCandidateHomePage> {
  final CardSwiperController controller = CardSwiperController();


  RecruiterHomeController homeController = Get.put(RecruiterHomeController()) ;
  @override
  void initState() {
    homeController.recruiterHomeApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (homeController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (homeController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  homeController.recruiterHomeApi();
                },
              ),);
          } else if (homeController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              homeController.recruiterHomeApi();
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              homeController.recruiterHomeApi();
            }),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              endDrawer: const DrawerRecruiter(),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * .032),
                        child: Image.asset('assets/images/icon_flikka_logo.png',
                          height: Get.height * .032,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height * .03,),
                          Text(
                            "Find Candidate",
                            style: Theme
                                .of(context)
                                .textTheme
                                .displaySmall,
                          ),
                          Text(
                              "California USA",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Color(0xffCFCFCF),
                                  fontWeight: FontWeight.w400)
                          )
                        ],
                      ),
                      Builder(
                          builder: (context) {
                            return InkWell(
                                onTap: () =>
                                    Scaffold.of(context).openEndDrawer(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * .032),
                                  child: Image.asset(
                                    'assets/images/inactive.png',
                                    height: Get.height * .05,),
                                ));
                          }
                      ),
                    ],
                  ),
                  Flexible(
                    child: homeController.homeData.value.data == null ||
                        homeController.homeData.value.data?.length == 0 ?
                    const SeekerNoJobAvailable(message: "No Data Available",) :
                    CardSwiper(
                      controller: controller,
                      cardsCount: homeController.homeData.value.data?.length ?? 0,
                      numberOfCardsDisplayed: homeController.homeData.value.data?.length == 1 ? 1 : 2,
                      backCardOffset: const Offset(40, 40),
                      padding: const EdgeInsets.all(24.0),
                      cardBuilder: (context, index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,) {
                        return FindCandidateHomePageRecruiter(recruiterData: homeController.homeData.value.data?[index],);
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
}
