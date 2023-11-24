import 'dart:async';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Job Recruiter/bottom_bar/tab_bar.dart';
import 'SeekerBottomNavigationBar/tab_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer( const Duration(seconds: 5),
        () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          if(sp.getString("loggedIn") == "recruiter") {
            Get.offAll( () => TabScreenEmployer(index: 0,)) ;
          } else if (sp.getString("loggedIn") == "seeker") {
            Get.offAll(const TabScreen(index: 0)) ;
          } else {
            Get.off(() => const Login());
          }
        }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/icon_splash_logo.jpg",fit: BoxFit.cover),
      ),
    );
  }
}
