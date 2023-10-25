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
  // String selectedItmeC = 'Social Marketing';
  // String selectedItmeS = 'Content Manager';
  // String selectedItmeL = 'California';

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
    'Date posted','Date decline','Date format',
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

  // double _startValue = 0;
  // double _endValue = 100;
  // List<String> dropdownOptionC = ['Social Marketing','Programming','Health Finance','Content Manager'];
  // List<String> dropdownOptionS = ['Elearnign','Programming','Services','Content Manager'];
  // List<String> dropdownOptionL = ['India','Pakistan','California','Kajira'];
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
            // SizedBox(height: Get.height*0.05,),
            // Text("Filter",style: Get.theme.textTheme.displayLarge),
            SizedBox(height: Get.height*0.03,),
            //*************** category *************
            Text('Job Position',style: Get.theme.textTheme.titleSmall),
            SizedBox(height: Get.height*0.01,),
            Center(
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint:  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Social Marketing',
                          style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
                  buttonStyleData: ButtonStyleData(
                    height: Get.height*0.078,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),

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
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),

            SizedBox(height: Get.height*0.03,),
            Text('Location',style: Get.theme.textTheme.titleSmall),
            SizedBox(height: Get.height*0.01,),
            Center(
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint:  Row(
                    children: [

                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'California',
                          style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
                  buttonStyleData: ButtonStyleData(
                    height: Get.height*0.078,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),

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
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height*.067,
                 width: Get.width*.28,
                  decoration: BoxDecoration(
                 border: Border.all(color: Color(0xff686868)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child:
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint:  Row(
                          children: [

                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Date posted',
                                style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
                        buttonStyleData: ButtonStyleData(
                          height: Get.height*0.078,
                          width: double.infinity,
                          padding:  EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),

                            //color: Color(0xff353535),
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
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height*.067,
                  width: Get.width*.28,
                  decoration: BoxDecoration(
                     border: Border.all(color: Color(0xff686868)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:  Center(
                    child:
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint:  Row(
                          children: [

                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Remote',
                                style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: itemsRemote
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: remoteValue,
                        onChanged: (String? value) {
                          setState(() {
                            remoteValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: Get.height*0.078,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),

                            //color: Color(0xff353535),
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
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height*.067,
                  width: Get.width*.3,
                  decoration: BoxDecoration(
                   border: Border.all(color: Color(0xff686868)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child:
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint:  Row(
                          children: [

                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Salary estimate',
                                style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: itemsSalary
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: salaryValue,
                        onChanged: (String? value) {
                          setState(() {
                            salaryValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: Get.height*0.078,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),

                           // color: Color(0xff353535),
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
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height*0.2,),
            Center(
              child: MyButton(title: "APPLY NOW", onTap1: () {

              },),
            ),
          ],
        ),
      ),
    );
  }
}
