import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page_recruiter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

class FindCandidateHomePage extends StatefulWidget {
  const FindCandidateHomePage({super.key});

  @override
  State<FindCandidateHomePage> createState() => _FindCandidateHomePageState();
}

class _FindCandidateHomePageState extends State<FindCandidateHomePage> {
  final CardSwiperController controller = CardSwiperController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  List<String> cards = [
    'assets/images/swiperbg.png', 'assets/images/swiperbg.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerRecruiter(),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height*.032),
                  child: Image.asset('assets/images/icon_flikka_logo.png',height: Get.height*.032,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height*.03,),
                    Text(
                      "Find Candidate",
                      style:Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                        "California USA",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400)
                    )
                  ],
                ),
                Builder(
                    builder: (context) {
                      return InkWell(
                          onTap: ()=> Scaffold.of(context).openEndDrawer(),
                          child: Padding(
                            padding:  EdgeInsets.only(top: Get.height*.032),
                            child: Image.asset('assets/images/inactive.png',height: Get.height*.05,),
                          ));
                    }
                ),
              ],
            ),
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                numberOfCardsDisplayed: 2,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                    ) {
                  return const FindCandidateHomePageRecruiter();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
