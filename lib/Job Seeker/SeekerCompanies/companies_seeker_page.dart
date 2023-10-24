import 'package:flikka/controllers/CompaniesListController/CompaniesListController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../res/components/server_error_widget.dart';
import '../../res/components/unauthorised_request_widget.dart';
import 'rating_page_seeker.dart';

class CompanySeekerPage extends StatefulWidget {
  const CompanySeekerPage({super.key});

  @override
  State<CompanySeekerPage> createState() => _CompanySeekerPageState();
}

class _CompanySeekerPageState extends State<CompanySeekerPage> {

  CompaniesListController companiesListController = Get.put(CompaniesListController()) ;

  @override
  void initState() {
    companiesListController.getCompaniesApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (companiesListController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (companiesListController
              .error.value ==
              'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {},
            ),);
          } else if (companiesListController
              .error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {}),);
          } else if (companiesListController
              .error.value == "Internal server error") {
            return Scaffold(body: ServerErrorWidget(onPress: () {}),);
          } else if (companiesListController.
          error.value == "Unauthorised Request") {
            return Scaffold(body: UnauthorisedRequestWidget(onPress: () {}),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {}),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(

              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * .02,),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(
                                "assets/images/icon_back_blue.png",
                                height: Get.height * .05,)),
                          SizedBox(width: Get.width * .04,),
                          Text("Companies", style: Get.theme.textTheme
                              .displayLarge),
                        ],
                      ),
                      SizedBox(height: Get.height * .03,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Get.width *
                            .05, vertical: Get.height * .008),
                        decoration: BoxDecoration(
                          color: const Color(0xff373737),
                          borderRadius: BorderRadius.circular(33.0),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Color(0xff56B8F6),
                              size: 30,),
                            SizedBox(width: Get.width * .03),
                            Expanded(
                              child: TextFormField(
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    color: const Color(0xffCFCFCF), fontSize: 19),
                                onChanged: (query) {
                                  companiesListController.filterList(query) ;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Example Company',
                                  hintStyle: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: const Color(0xffCFCFCF)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 10),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.black, // Customize the background color
                      //   ),
                      //   //padding: EdgeInsets.all(8), // Adjust the padding as needed
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       IconButton(
                      //         constraints: BoxConstraints(),
                      //         onPressed: () {},
                      //         icon: Image.asset('assets/images/addfileoncompany.png'),
                      //       ),
                      //       SizedBox(width: 8), // Add spacing between the icon and text
                      //       Flexible( // Allow the text to wrap if necessary
                      //         child: Text(
                      //           "Add new company",
                      //           style: Get.theme.textTheme.bodySmall!.copyWith(color: Colors.white),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: Get.height*.015,) ,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: companiesListController.companies?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = companiesListController.companies?[index] ;
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const RattingPage());
                                },
                                child: ListTile(
                                  leading:  CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage(
                                          '${data?.profileImg}')
                                  ),
                                  title: Text(data?.companyName ?? "Demo Name",
                                      style: Get.theme.textTheme.labelMedium!
                                          .copyWith(color: AppColors.white)),
                                  subtitle: Text(data?.companyLocation ?? "Demo Location",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(color: Color(0xffCFCFCF))),
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
              ),
            ),
          );
      }
    }
    );
  }
}
