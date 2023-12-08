import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/SeekerForumController/ForumIndustryListController.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../widgets/app_colors.dart';

class AddNewForum extends StatefulWidget {
  const AddNewForum({Key? key}) : super(key: key);

  @override
  State<AddNewForum> createState() => _AddNewForumState();
}

class _AddNewForumState extends State<AddNewForum> {

  SeekerForumIndustryController industryController = Get.put(SeekerForumIndustryController()) ;
  @override
  void initState() {
   industryController.industryApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          } else if (industryController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              industryController.industryApi();
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              industryController.industryApi();
            }),);
          }
        case Status.COMPLETED:
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * .04,),
                    Row(
                      children: [
                        SizedBox(height: Get.height * .13,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/images/icon_back_blue.png",
                                  height: Get.height * .055,))),
                        SizedBox(width: Get.width * .04,),
                        Text("Add New Forum", style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),),
                      ],
                    ),
                    SizedBox(height: Get.height * .01,),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          'Select Industry',
                          style: Get.theme.textTheme.bodyLarge!.copyWith(
                              color: AppColors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,),
                        items: industryController.industryData.value
                            .industryList?.map((item) =>
                            DropdownMenuItem(
                              value: item.id,
                              child: Text(item.industryPreferences.toString(),
                                style: Get.theme.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.white,
                                    fontSize: 12),
                                overflow: TextOverflow.ellipsis,),
                              onTap: () {
                                setState(() {

                                });
                              },
                            )).toList(),
                        // value: jobTitleValue,
                        onChanged: (value) {},
                        buttonStyleData: ButtonStyleData(
                          height: Get.height * 0.06,
                          width: Get.width * .29,
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
                          width: Get.width * .42,
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
                    SizedBox(height: Get.height * .04,),
                    TextFormField(
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff454545),
                          hintText: "Add tittle",
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Color(0xffCFCFCF),
                              fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.symmetric(vertical: Get
                              .height * .03, horizontal: Get.width * .06),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Color(0xff454545)),
                          ),

                        )
                    ),
                    SizedBox(height: Get.height * .04,),
                    TextFormField(
                        maxLines: 5,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff454545),
                          hintText: "Add description...",
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Color(0xffCFCFCF),
                              fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.symmetric(vertical: Get
                              .height * .03, horizontal: Get.width * .07),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0xff454545)),
                          ),

                        )
                    ),
                    SizedBox(height: Get.height * .06,),
                    MyButton(
                      width: Get.width * .72,
                      title: "SUBMIT", onTap1: () {

                    },)
                  ],
                ),
              ),
            ),
          );
      }
    }
    );
  }
}
