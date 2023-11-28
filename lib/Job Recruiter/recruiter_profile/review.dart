import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/AddReview/AddReview.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../../widgets/app_colors.dart';

class Review extends StatefulWidget {
  final bool isSeeker ;
 final RxList<CompanyReviewsModel>? reviews ;
 final String? recruiterID ;
  const Review({super.key, required this.isSeeker, this.reviews, this.recruiterID});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double ratingValue = 1 ;
  String? totalReviews = "256" ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height*.045,),
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reviews",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: const Color(0xffFFFFFF)),),
               widget.isSeeker ? MyButton( width: Get.width *.5,
                    title: "ADD A REVIEW",
                    onTap1: () {
                  Get.to( () => AddReview(recruiterID: widget.recruiterID,) ) ;
                    }) :
                   const SizedBox()
              ],
            ),
            SizedBox(height: Get.height*.005,),
            widget.reviews == null || widget.reviews?.length == 0 ?
            Text("No reviews have been added",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),) :
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: ratingValue,
                  minRating: 1,
                  maxRating: ratingValue,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 40.0,
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(height: Get.height*.02,),
                Text("($totalReviews total reviews)"),
                SizedBox(height: Get.height*.02,),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.reviews?.length,
                    itemBuilder: (context , index) {
                    var data = widget.reviews?[index] ;
                  return Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile( contentPadding: EdgeInsets.zero,
                        leading: CachedNetworkImage(imageUrl: data?.seekerInfo?[0].profileImg ?? "https://urlsdemo.xyz/flikka/images/seekers/defalt_profile.png",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image:  DecorationImage(
                                  image: imageProvider,fit: BoxFit.cover
                              ) ,
                            ),
                          ),
                          placeholder: (context, url) => const CircularProgressIndicator(),),
                        title: Text(data?.seekerInfo?[0].fullname ?? "",overflow: TextOverflow.ellipsis,style: Theme.of(context).
                        textTheme.titleSmall?.copyWith(color: const Color(0xffFFFFFF),fontWeight: FontWeight.w700),),
                        subtitle: Text(data?.seekerDetailsInfo?[0].positions ?? "",overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge?.
                        copyWith(color: const Color(0xffCFCFCF),fontWeight: FontWeight.w400)),
                      ) ,
                       HtmlWidget(data?.description ?? "",textStyle:Theme.of(context).textTheme.labelLarge?.
                       copyWith(color: const Color(0xffCFCFCF),fontWeight: FontWeight.w400),),
                      SizedBox(height: Get.height * 0.02,)
                    ],);
                  }),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
