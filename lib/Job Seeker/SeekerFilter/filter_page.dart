import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final List<String> itemsC = [
    'Social Marketing','Programming','Health Finance','Content Manager'
  ];
  String? socialValue;

  final List<String> itemsS = [
    'Elearning','Programming','Services','Content Manager'
  ];
  String? contentValue;

  final List<String> itemsL = [
    'India','Pakistan','California','Kajira'
  ];
  String? countryValue;


  final List<String> itemsDate = [
    '1 Day', '3 Day', '6 Day', '9 Day', '1 Month' ,
  ];
  String? dateValue;


  final List<String> itemsRemote = [
    'Remote','one','two', 'three',
  ];
  String? remoteValue;


  final List<String> itemsSalary = [
    'Salary estimate','one','two', 'three',
  ];
  String? salaryValue;

  final List<String> companyItems = [
    'Test','Demo','Testing',
  ];
  String? companyValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back() ;
        }, icon: Image.asset("assets/images/icon_back_blue.png",)),
        title: Text("Filter",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height*0.03,),
            //*************** category *************
            Text('Job Position',style: Get.theme.textTheme.titleSmall),
            SizedBox(height: Get.height*0.01,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 5),
              height: Get.height*.07,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.textFieldFilledColor,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child:
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w300),
                    isExpanded: true,
                    hint:Text(
                      'Select position',
                      style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: itemsC
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: socialValue,
                    onChanged: (String? value) {
                      setState(() {
                        socialValue = value;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: Get.height*0.35,
                      width: Get.width*0.400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xff353535),
                      ),
                      offset: const Offset(5, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius:  Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 15, right: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03,),
            Text('Location',style: Get.theme.textTheme.titleSmall),
            SizedBox(height: Get.height*0.01,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 5),
              height: Get.height*.07,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.textFieldFilledColor,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child:
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w300),
                    isExpanded: true,
                    hint: Text(
                      'Select location',
                      style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: itemsL
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: countryValue,
                    onChanged: (String? value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: Get.height*0.35,
                      width: Get.width*0.400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xff353535),
                      ),
                      offset: const Offset(5, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius:  Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 15, right: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03,),
            Text('Company Name',style: Get.theme.textTheme.titleSmall),
            SizedBox(height: Get.height*0.01,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 5),
              height: Get.height*.07,
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColors.textFieldFilledColor,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child:
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w300),
                    isExpanded: true,
                    hint: Text(
                      'Select Company',
                      style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: companyItems
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: companyValue,
                    onChanged: (String? value) {
                      setState(() {
                        companyValue = value;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: Get.height*0.35,
                      width: Get.width*0.400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xff353535),
                      ),
                      offset: const Offset(5, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius:  Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 15, right: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.05,),
            Container(
              height: Get.height*.06,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                return Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    // height: Get.height*.062,
                    width: Get.width*.34,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.whiteBorderColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w300),
                          isExpanded: true,
                          hint: Text(
                            'Date posted',
                            style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemsDate
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: dateValue,
                          onChanged: (String? value) {
                            setState(() {
                              dateValue = value;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height*0.35,
                           // width: Get.width*0.902,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 10, right: 5),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },),
            ) ,
            SizedBox(height: Get.height*0.04,),
            Container(
              height: Get.height*.2,
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: Get.height*.1,
                    width: Get.width*.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.textFieldFilledColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*.025,),
                          Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(image: AssetImage("assets/images/icon_marketing.png"))
                                ),
                              ),
                              SizedBox(width: 12,),
                              Text("Marketing Intern",style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ),
                          SizedBox(height: Get.height*.02,),
                          RichText(text: TextSpan(
                            text: "£145k-£200k",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: AppColors.blueThemeColor),
                            children: [
                              TextSpan(text: "/yr",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: AppColors.white))
                            ]
                          ),) ,
                          // SizedBox(height: Get.height*.02,),
                          Row(
                            children: [
                              Image.asset("assets/images/icon_location_filter.png",height: Get.height*.05,),
                              SizedBox(width: Get.width*.02,),
                              Text("California, USA",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.graySilverColor),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },),
            ),
            SizedBox(height: Get.height*0.04,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 height: Get.height*.07,
                 width: Get.width*.35,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(30),
                   color: AppColors.white
                 ),
                 child: Center(child: Text("RESET",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),)),
               ),
               SizedBox(width: Get.width*.025,),
               MyButton(
                 height: Get.height*.07,
                 width: Get.width*.35,
                 title: "APPLY", onTap1: () {

               },)
             ],
           ),
            SizedBox(height: Get.height*.1,)
          ],
        ),
      ),
    );
  }
}
