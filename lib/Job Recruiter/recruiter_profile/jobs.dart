import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruiterJobs extends StatefulWidget {
  final List<RecruiterJobsData>? recruiterJobsData ;
  final String? company ;
  final String? location ;
  const RecruiterJobs({super.key, this.recruiterJobsData, this.company, this.location});

  @override
  State<RecruiterJobs> createState() => _RecruiterJobsState();
}

class _RecruiterJobsState extends State<RecruiterJobs> {

  String formatDateTime(DateTime? dateTime) {
    if(dateTime != null) {
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
      } else {
        final months = difference.inDays ~/ 30;
        return '$months month${months > 1 ? 's' : ''} ago';
      }
    }else {
      return "No Data" ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0x000ff000),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*.06,),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.recruiterJobsData?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = widget.recruiterJobsData?[index] ;
                  String uploadingTime = formatDateTime(data?.createdAt) ;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: Get.height*.18,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: const Color(0xff353535),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      minVerticalPadding: 13,
                      leading: CachedNetworkImage(
                        imageUrl: "${data?.featureImg}",
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
                        placeholder: (context, url) => CircularProgressIndicator(),
                      ),
                      title: Text(data?.jobPositions ?? "No Data",overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Color(0xffFFFFFF),fontWeight: FontWeight.w700),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*.001,),
                          Text(widget.company ?? "No Data",overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge?.copyWith(color: const Color(0xffCFCFCF),fontWeight: FontWeight.w400)
                          ),
                          SizedBox(height: Get.height*.001,),
                          Text(data?.jobLocation ?? "No Data",overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                          SizedBox(height: Get.height*.001,),
                          Text(uploadingTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall?.copyWith(color: const Color(0xff9D9D9D),fontWeight: FontWeight.w400)
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.more_vert,color: Colors.white,size: 25,),
                    ),
                  ),
                );
              },
              )
            ],
          ),
        ),
    )
    );
  }
}
