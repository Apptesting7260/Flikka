import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EditBankAccountDetail extends StatefulWidget {
  const EditBankAccountDetail({super.key});

  @override
  State<EditBankAccountDetail> createState() => _EditBankAccountDetailState();
}

class _EditBankAccountDetailState extends State<EditBankAccountDetail> {

  final bankController = TextEditingController();
  final nameController = TextEditingController();
  final branchController = TextEditingController();
  final acNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(children: [
            Row(children: [
              SizedBox(width: Get.width*0.05,),

              GestureDetector(
                onTap: () {Get.back();}, // Image tapped
                child: Image.asset(
                  'assets/images/backicon.png',
                  // fit: BoxFit.cover, // Fixes border issues
                  width: Get.width*0.1,
                  height: Get.height*0.1,
                ),
              )
            ],),

            Row(
              children: [
                SizedBox(width: Get.width*0.08,),
                Text("Bank account details ", style: TextStyle(fontSize: 20,fontWeight:   FontWeight.w700,color: Colors.white )),
              ],
            ),
            SizedBox(height: Get.height*0.025,),
            Row(children: [
              SizedBox(width: Get.width*0.08,),
              Text('Bank',style: TextStyle(fontSize: 16,fontWeight:   FontWeight.w700,color: Colors.white )),
            ],),
            SizedBox(height: Get.height*0.01,),
            Row(
              children: [
                SizedBox(width: Get.width*0.08,),
                Container(
                  width: Get.width*0.83,
                  height: Get.height*0.075,
                  decoration: BoxDecoration(color: Color.fromRGBO(55, 55, 55, 1), borderRadius: BorderRadius.circular(60)),
                  child:
                  TextFormField(
                    controller: bankController,
                    readOnly: true,
                    style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      hintStyle: TextStyle(fontSize: 14.0, color: Color.fromRGBO(255, 255, 255, 1)),
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),

                    ),
                  ),
                ),
              ],),

            SizedBox(height: Get.height*0.03,),
            Row(children: [
              SizedBox(width: Get.width*0.08,),
              Text('Account Holder Name',style: TextStyle(fontSize: 16,fontWeight:   FontWeight.w700,color: Colors.white )),
            ],),
            SizedBox(height: Get.height*0.01,),

            Row(
              children: [
                SizedBox(width: Get.width*0.08,),
                Container(
                  width: Get.width*0.83,
                  height: Get.height*0.075,
                  decoration: BoxDecoration(color: Color.fromRGBO(55, 55, 55, 1), borderRadius: BorderRadius.circular(60)),
                  child:  TextFormField(
                    readOnly: true,
                    controller: nameController,
                    style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      hintStyle: TextStyle(fontSize: 14.0, color: Color.fromRGBO(255, 255, 255, 1)),
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),

                    ),
                  ),
                ),

              ],),

            SizedBox(height: Get.height*0.03,),
            Row(children: [
              SizedBox(width: Get.width*0.08,),
              Text('Branch Code',style: TextStyle(fontSize: 16,fontWeight:   FontWeight.w700,color: Colors.white )),
            ],),
            SizedBox(height: Get.height*0.01,),

            Row(
              children: [
                SizedBox(width: Get.width*0.08,),
                Container(
                  width: Get.width*0.83,
                  height: Get.height*0.075,
                  decoration: BoxDecoration(color: Color.fromRGBO(55, 55, 55, 1), borderRadius: BorderRadius.circular(60)),
                  child:  TextFormField(
                    readOnly: true,
                    controller: branchController,
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enter code',
                      hintStyle: TextStyle(fontSize: 14.0, color: Color.fromRGBO(255, 255, 255, 1)),
                      contentPadding: EdgeInsets.all(17.0),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),

                    ),
                  ),
                ),

              ],),

            SizedBox(height: Get.height*0.03,),
            Row(children: [
              SizedBox(width: Get.width*0.08,),
              Text('Account Number',style: TextStyle(fontSize: 16,fontWeight:   FontWeight.w700,color: Colors.white )),
            ],),
            SizedBox(height: Get.height*0.01,),

            Row(
              children: [
                SizedBox(width: Get.width*0.08,),
                Container(
                  width: Get.width*0.83,
                  height: Get.height*0.075,
                  decoration: BoxDecoration(color: Color.fromRGBO(55, 55, 55, 1), borderRadius: BorderRadius.circular(60)),
                  child:  TextFormField(   readOnly: true,
                    controller: acNumberController,
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enter account number',
                      hintStyle: TextStyle(fontSize: 14.0, color: Color.fromRGBO(255, 255, 255, 1)),
                      contentPadding: EdgeInsets.all(17.0),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),

                    ),
                  ),
                ),

              ],),

            SizedBox(height: Get.height*0.05,),
            // Row(mainAxisAlignment: MainAxisAlignment.center,
            //   children: [GestureDetector(
            //     onTap: () {
            //
            //     },
            //     child: Container(
            //       height: Get.height*0.05,
            //       width: Get.width*0.6,
            //       decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //               colors: [
            //                 Color(0xff56B8F6),
            //                 Color(0xff4D6FED)
            //               ],begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter
            //
            //           ),
            //           borderRadius: BorderRadius.circular(60)
            //       ),
            //       child:  Center(
            //         child: Text('Edit',style: TextStyle(fontSize: 17,fontWeight:   FontWeight.w700,color: Colors.white )),
            //
            //       ),),
            //   )],),
            MyButton(
              width: Get.width*.7,
              title: "EDIT", onTap1: () {

            },)

          ],),
        ),
      ),
    );
  }
}