import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewForum extends StatefulWidget {
  const AddNewForum({Key? key}) : super(key: key);

  @override
  State<AddNewForum> createState() => _AddNewForumState();
}

class _AddNewForumState extends State<AddNewForum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
          child: Column(
            children: [
              SizedBox(height: Get.height*.04,),
              Row(
                children: [
                  SizedBox(height: Get.height*.13,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,))),
                  SizedBox(width: Get.width*.04,),
                  Text("Add New Forum",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                ],
              ),
              SizedBox(height: Get.height*.02,),
              Container(
                height: Get.height*.74,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xff353535),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
                  child: Column(
                    children: [
                     SizedBox(height: Get.height*.07,),
                      Text("Add New Forum",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                      SizedBox(height: Get.height*.04,),
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff454545),
                            hintText: "Add tittle",
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(vertical: Get.height*.03,horizontal: Get.width*.06),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:BorderSide(
                                  color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(color: Color(0xff454545)),
                            ),

                          )
                      ),
                      SizedBox(height: Get.height*.04,),
                      TextFormField(
                          maxLines: 5,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff454545),
                            hintText: "Add description...",
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(vertical: Get.height*.03,horizontal: Get.width*.07),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:BorderSide(
                                  color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xff454545)),
                            ),

                          )
                      ),
                      SizedBox(height: Get.height*.06,),
                      MyButton(title: "SUBMIT", onTap1: () {

                      },)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
