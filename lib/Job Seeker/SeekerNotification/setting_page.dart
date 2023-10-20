import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
              child: Image.asset('assets/images/icon_back_blue.png')),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text("Settings",style: Get.theme.textTheme.displayLarge),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height*0.04,),
            Container(
              height: Get.height*0.08,
              width: Get.width*0.9,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconButton(onPressed: (){} ,icon: Image.asset('assets/images/notificationfull.png')),
                    Text("Notifications",style: Get.theme.textTheme.bodyMedium),
                  ],),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: AdvancedSwitch(
                      controller: _controller,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      activeChild: Text('ON'),
                      inactiveChild: Text('OFF',style: TextStyle(
                        color: Colors.black
                      ),),
                      activeImage: AssetImage('assets/images/switchon.png'),
                      inactiveImage: AssetImage('assets/images/whites.jpg'),
                      borderRadius: BorderRadius.all(const Radius.circular(15)),
                      width: Get.width*0.15,
                      height: Get.height*0.04,
                      enabled: true,
                      disabledOpacity: 0.5,
                    ),
                  ),

                ],
              )
            ),
            SizedBox(height: Get.height*0.022,),
            Container(
                height: Get.height*0.08,
                width: Get.width*0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      IconButton(onPressed: (){} ,icon: Image.asset('assets/images/lockicon.png')),
                      Text("Password",style: Get.theme.textTheme.bodyMedium),
                    ],),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,size: 15,))
                  ],
                )
            ),
            SizedBox(height: Get.height*0.022,),
            Container(
                height: Get.height*0.08,
                width: Get.width*0.9,
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      IconButton(onPressed: (){} ,icon: Image.asset('assets/images/logout.png')),
                      Text("Logout",style: Get.theme.textTheme.bodyMedium),
                    ],),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,size: 15,))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
