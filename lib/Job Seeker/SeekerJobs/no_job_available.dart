import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SeekerNoJobAvailable extends StatefulWidget {
  const SeekerNoJobAvailable({super.key});

  @override
  State<SeekerNoJobAvailable> createState() => _SeekerNoJobAvailableState();
}

class _SeekerNoJobAvailableState extends State<SeekerNoJobAvailable> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("called") ;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: Get.height*.07,),
            Center(child: Image.asset("assets/images/icon_no_job.png")),
            Text("No Job Available!",style: Theme.of(context).textTheme.displayLarge,),
            SizedBox(height: Get.height*.01,),
            Center(child: SizedBox(
              width: Get.width*.7,
                child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.", textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF),))))
          ],
        ),
      ),
    ));
  }
}
