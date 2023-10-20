import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class AllCandidate extends StatefulWidget {
  const AllCandidate({super.key});

  @override
  State<AllCandidate> createState() => _AllCandidateState();
}

class _AllCandidateState extends State<AllCandidate> {

  final List<String> jobTypeItems = [
    'Social Marketing','Programming','Health Finance','Content Manager'
  ];
  String? jobTypeValues;

  final List<String> allTypeItems = [
    'Selected','Rejected',
  ];
  String? allTypeValues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*.04,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.008),
                decoration: BoxDecoration(
                  color: Color(0xff373737),
                  borderRadius: BorderRadius.circular(33.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xff56B8F6),size: 27,),
                    SizedBox(width: Get.width*.03),
                    Expanded(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                        onChanged: (query){
                          // filterPositionNames(query);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("All Candidate",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF))),
                    ],
                  ),
                  Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Job Type',
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: jobTypeItems
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: jobTypeValues,
                          onChanged: (String? value) {
                            setState(() {
                              jobTypeValues = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.065,
                            width: Get.width*.29,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                                border: Border.all(color: Color(0xff686868))
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
                      SizedBox(width: Get.width*.02,),
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
                                  'All',
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: allTypeItems
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: allTypeValues,
                          onChanged: (String? value) {
                            setState(() {
                              allTypeValues = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.065,
                            width: Get.width*.29,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(color: Color(0xff686868))
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
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: Get.height*.035,),
              Container(
                height: Get.height*.35,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xff353535),
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height*.013,),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //     child: Padding(
                      //       padding:  EdgeInsets.only(right: Get.width*.05),
                      //       child: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                      //     )),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 15,
                        leading: CircleAvatar(
                          radius: 27,
                          backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                        ),
                            title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height*.003,),
                            Text(
                                "Software engineer ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                            ),
                            SizedBox(height: Get.height*.003,),
                            Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                          ],
                        ),
                         trailing: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                      ),
                      SizedBox(height: Get.height*.017,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(
                            width: Get.width*.32,
                            height: Get.height*.066,
                            title: "ACCEPT", onTap1: () {

                          },),
                          SizedBox(
                            width:   Get.width*.32,
                            height: Get.height*.066,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffFFFFFF),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: Text("REJECT",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                  // barrierDismissible: false,
                                    context: context, builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                    backgroundColor: Color(0xff353535),
                                    contentPadding: EdgeInsets.zero,
                                    content:
                                    Container(
                                      alignment: Alignment.center,
                                      height:Get.height*.5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: Get.height*0.001,),
                                          Center(child:
                                          Text("Save Notes",style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.white,fontSize: 20,fontWeight: FontWeight.w600),)
                                          ),
                                          SizedBox(height: Get.height*.02,),
                                          Center(child:
                                          Text("Lorem Ipsum is simply industry.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)
                                          ),
                                          SizedBox(height: Get.height*.03,),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                                            child: TextFormField(
                                                maxLines: 4,
                                                style: Theme.of(context).textTheme.bodyMedium,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xff1A1A1A),
                                                  hintText: "Enter Note",
                                                  hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF)),
                                                  contentPadding: EdgeInsets.symmetric(vertical: Get.height*.03,horizontal: Get.width*.05),
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                                                      borderSide: BorderSide(color: Color(0xff1A1A1A))),

                                                  enabledBorder:  OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(22),
                                                    // borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                                                    borderSide: BorderSide(color: Colors.red),
                                                  ),
                                                  disabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                                                    borderSide: BorderSide(color: Color(0xff373737)),
                                                  ),

                                                )
                                            ),
                                          ),
                                          SizedBox(height: Get.height*0.03,),
                                          MyButton(
                                            width: Get.width*.65,
                                            title: "SAVE", onTap1: () {

                                          },)
                                        ],),
                                    ),
                                  );
                                }
                                );
                              },
                              child: Image.asset("assets/images/icon_save_request.png",height: Get.height*.06,)),
                        ],
                      ),
                      SizedBox(height: Get.height*.027,),
                      SizedBox(
                        width:   295,
                        height: Get.height*.066,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                             primary: Color(0xff353535),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Color(0xffFFFFFF))),
                          ),
                          child: Text("TALENT POOL",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*.03,),
              Container(
                height: Get.height*.29,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color(0xff353535),
                    borderRadius: BorderRadius.circular(24)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height*.013,),
                      // Align(
                      //     alignment: Alignment.topRight,
                      //     child: Padding(
                      //       padding:  EdgeInsets.only(right: Get.width*.05),
                      //       child: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                      //     )),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 15,
                        leading: CircleAvatar(
                          radius: 27,
                          backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                        ),
                        title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height*.003,),
                            Text(
                                "Software engineer ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                            ),
                            SizedBox(height: Get.height*.003,),
                            Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                            SizedBox(height: Get.height*.003,),
                            Text("SELECTED",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff42D396)),),

                          ],
                        ),
                        trailing: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                      ),
                      SizedBox(height: Get.height*.024,),
                      MyButton(
                        height: Get.height*.066,
                        title: "VIEW PROFILE", onTap1: () {

                      },),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*.035,),
              Container(
                height: Get.height*.38,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color(0xff353535),
                    borderRadius: BorderRadius.circular(24)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height*.013,),
                      // Align(
                      //     alignment: Alignment.topRight,
                      //     child: Padding(
                      //       padding:  EdgeInsets.only(right: Get.width*.05),
                      //       child: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                      //     )),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 15,
                        leading: CircleAvatar(
                          radius: 27,
                          backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                        ),
                        title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ SizedBox(height: Get.height*.003,),
                            Text(
                                "Software engineer ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                            ),
                            SizedBox(height: Get.height*.003,),
                            Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                            SizedBox(height: Get.height*.003,),
                            Text("REJECTED",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff42D396)),),

                          ],
                        ),
                        trailing: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                      ),
                      SizedBox(height: Get.height*.024,),
                      MyButton(
                        height: Get.height*.066,
                        title: "VIEW PROFILE", onTap1: () {

                      },),
                      SizedBox(height: Get.height*.024,),
                      SizedBox(
                        width:   295,
                        height: Get.height*.066,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff353535),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Color(0xffFFFFFF))),
                          ),
                          child: Text("TALENT POOL",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*.08,),
            ],
          ),
        ),
      ),
    );
  }
}
