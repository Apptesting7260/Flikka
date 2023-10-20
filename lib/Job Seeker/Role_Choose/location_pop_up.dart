
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'import_cv.dart';

class LocationPopUp extends StatefulWidget {

   const LocationPopUp({Key? key}) : super(key: key);

  @override
  State<LocationPopUp> createState() => _LocationPopUpState();
}

class _LocationPopUpState extends State<LocationPopUp> {
  int  role=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
            child: Center(
              child: Container(
                height: Get.height*.4,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xff353535),
                  borderRadius: BorderRadius.circular(22)
                ),
                child: Column(
                  children: [
                    SizedBox(height: Get.height*.06,),
                    Image.asset("assets/images/location_icon.png",height: Get.height*.09,),
                    SizedBox(height: Get.height*.01,),
                    Text("Welcome!",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                    SizedBox(height: Get.height*.01,),
                    Text("Know your location",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                    SizedBox(height: Get.height*.03,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 56,
                            width: Get.width*.37,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() =>  ImportCv(role: role,));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff353535),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  side: BorderSide(color: Color(0xff8E8E8E))
                              ), child: Text("BLOCK",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff8E8E8E)),),
                            ),
                          ),
                          SizedBox(
                            height: 56,
                            width: Get.width*.37,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() =>  ImportCv(role: role,));
                                },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff353535),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  side: BorderSide(color: Color(0xff8E8E8E))
                              ), child: Text("ALLOW",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff8E8E8E)),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
