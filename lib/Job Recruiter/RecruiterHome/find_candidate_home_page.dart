import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page_recruiter.dart';
import 'package:flikka/controllers/RecruiterHomeController/RecruiterHomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Job Seeker/SeekerJobs/no_job_available.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';


class FindCandidateHomePage extends StatefulWidget {
  const FindCandidateHomePage({super.key});

  @override
  State<FindCandidateHomePage> createState() => _FindCandidateHomePageState();
}

class _FindCandidateHomePageState extends State<FindCandidateHomePage> {

  final CardSwiperController controller = CardSwiperController();

  RecruiterHomeController homeController = Get.put(RecruiterHomeController()) ;
  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    homeController.recruiterHomeApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    homeController.recruiterHomeApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  final List<String> itemsEmp = ['marketing intern','software developer','web developer', 'internship', 'fresher' ,];
  String? employmentType;

  @override
  void initState() {
    homeController.recruiterHomeApi() ;
    jobTitleController.recruiterJobTitleApi() ;
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
              body: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Column(
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
                            ),
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
                    SizedBox(height: Get.height*.03,) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Sort By",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),) ,
                       const SizedBox(width: 12,) ,
                       DropdownButtonHideUnderline(
                         child: DropdownButton2<String>(
                           // focusNode: jobTypeFocus ,
                           isExpanded: true,
                           hint:  Text(
                             'Select',
                             style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                             overflow: TextOverflow.ellipsis,
                           ),
                           items: itemsEmp
                               .map((String item) => DropdownMenuItem<String>(
                             value: item,
                             child: Text(
                               item,
                               style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                               overflow: TextOverflow.ellipsis,
                             ),
                           ))
                               .toList(),
                           value: employmentType,
                           onChanged: (String? value) {
                             setState(() {
                               employmentType = value;
                             });
                           },
                           buttonStyleData: ButtonStyleData(
                             height: Get.height*0.06,
                             width: Get.width*.5,
                             padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               border: Border.all(color: Color(0xff686868)),
                               color: Color(0xff353535),
                             ),
                             elevation: 2,
                           ),
                           iconStyleData:  IconStyleData(
                             icon: Image.asset('assets/images/arrowdown.png'),
                             iconSize: 14,
                             iconEnabledColor: Colors.yellow,
                             iconDisabledColor: Colors.grey,
                           ),
                           dropdownStyleData: DropdownStyleData(
                             maxHeight: Get.height*0.35,
                             width: Get.width*0.902,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(14),
                               color: const Color(0xff353535),
                             ),
                             offset: const Offset(5, 0),
                             scrollbarTheme: ScrollbarThemeData(
                               radius:  const Radius.circular(40),
                               thickness: MaterialStateProperty.all<double>(6),
                               thumbVisibility: MaterialStateProperty.all<bool>(true),
                             ),
                           ),
                           menuItemStyleData: const MenuItemStyleData(
                             height: 40,
                             padding: EdgeInsets.only(left: 14, right: 14),
                           ),
                         ),
                       ),
                     ],
                   ) ,
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
                        onSwipe: _onSwipe,
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
        showDialog(context: context, builder: (BuildContext context) {
          String? jobTitleValue;
          String? jobTitleID;
          RxString errorMessage = "".obs ;
          return Dialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            child: StatefulBuilder(
              builder: (context , setState) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height *.02, horizontal: Get.width * .04),
                  child: homeController.homeData.value.postedJob! ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Select the job for this profile") ,
                      SizedBox(height: Get.height *.02,) ,
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text( jobTitleValue ?? 'Select Title',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white, fontSize: 12),
                            overflow: TextOverflow.ellipsis,),
                          items: jobTitleController.getJobTitleDetails.value.jobTitleList?.map((item) =>
                              DropdownMenuItem(
                                value: item.jobTitle,
                                child: Text(item.jobTitle.toString(),
                                  style: Get.theme.textTheme.bodyLarge!
                                      .copyWith(color: AppColors.white,
                                      fontSize: 12),
                                  overflow: TextOverflow.ellipsis,),
                                onTap: () {
                                  setState(() {
                                    jobTitleValue = item.jobTitle;
                                    jobTitleID = item.id.toString() ;
                                    errorMessage.value = "" ;
                                  });
                                },)).toList(),
                          onChanged: (value) {},
                          buttonStyleData: ButtonStyleData(
                            height: Get.height * 0.06,
                            padding: const EdgeInsets.only(
                                left: 10, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                    color: const Color(0xff686868))
                              // color: Color(0xff353535),
                            ),
                            elevation: 2,
                          ),

                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<
                                  double>(6),
                              thumbVisibility: MaterialStateProperty.all<
                                  bool>(true),
                            ),
                          ),

                        ),
                      ),
                      Obx(() => errorMessage.isEmpty ? const SizedBox() :
                      Text(errorMessage.value , style: const TextStyle(color: AppColors.red),)),
                      SizedBox(height: Get.height *.02,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx( () =>
                            MyButton(
                                width: Get.width*.25,
                                height: Get.height*.05,
                                loading: applyJobController.loading.value,
                                title: "Select",
                                onTap1: () {
                                  if(jobTitleID != null) {
                                    applyJobController.applyJob( jobTitleID,seekerID: homeController.homeData.value.data?[previousIndex].id.toString(),) ;
                                  }else {
                                    errorMessage.value = "Select Job before selecting" ;
                                  }
                                } ),
                          ),
                          MyButton(
                            width: Get.width*.25,
                            height: Get.height*.05,
                            title: "Cancel",
                            onTap1: () {
                              Get.back();
                            },),
                        ],
                      )
                    ],
                  ) :
                  Column( mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Post any job to select candidates"),
                  SizedBox(height: Get.height *.02,) ,
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "Ok",
                    onTap1: () {
                      Get.back();
                    },),
                    ],
                  ),
                );
              }
            ),
          ) ;
        }) ;
        // CommonFunctions.confirmationDialog(context, message: "Do you want to Apply for the post", onTap: () {
        //   Get.back() ;
        //   CommonFunctions.showLoadingDialog(context, "Applying") ;
        //   // applyJobController.applyJob(getJobsListingController.getJobsListing.value.jobs?[previousIndex].id.toString()) ;
        // }) ;
      }
      // else if (direction.name == "top") {
      //   CommonFunctions.confirmationDialog(context, message: "Do you want to save the post", onTap: () {
      //     Get.back() ;
      //     CommonFunctions.showLoadingDialog(context, "Saving") ;
      //   }) ;
      // }
      debugPrint(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
      );
    }
    return true;

  }
}
