import 'package:flikka/controllers/SeekerAppliedJobsController/SeekerAppliedJobsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../widgets/app_colors.dart';

class SeekerAppliedJobs extends StatefulWidget {
  const SeekerAppliedJobs({super.key});

  @override
  State<SeekerAppliedJobs> createState() => _SeekerAppliedJobsState();
}

class _SeekerAppliedJobsState extends State<SeekerAppliedJobs> {

  SeekerAppliedJobsController jobsController = Get.put(SeekerAppliedJobsController()) ;

  @override
  void initState() {
    jobsController.getJobsApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (jobsController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );
        case Status.ERROR:
          if (jobsController.error.value == 'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {},
            ),);
          } else if (jobsController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {}),);
          }  else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {}),);
          }
        case Status.COMPLETED:
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/icon_back_blue.png")),
              title: Text("My Jobs", style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
              toolbarHeight: 45,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .04, vertical: Get.height * .02),
              child: jobsController.jobsList.value.job?.length == 0 || jobsController.jobsList.value.job == null ?
                  Center(child: Text("You have not Applied to any jobs", style: Get.theme.textTheme.labelMedium!
                     .copyWith(color: AppColors.white))) :
              Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobsController.jobsList.value.job?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = jobsController.jobsList.value.job?[index] ;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: ListTile(
                              leading:  CircleAvatar(
                                  radius: 26,
                                  backgroundImage: NetworkImage("${data?.featureImg}")),
                              title: Text("${data?.jobPositions}",
                                  style: Get.theme.textTheme.labelMedium!
                                      .copyWith(color: AppColors.white)),
                              subtitle: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data?.recruiterDetails?.companyName}",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(color: Color(0xffCFCFCF))),
                                  Text("${data?.recruiterDetails?.companyLocation}",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(color: Color(0xffCFCFCF))),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 40,
                            color: Color(0xff414141),
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                        ],
                      );
                    },)
                ],
              ),
            ),
          );
      }
    }
    );
  }

}
