import 'dart:async';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/Job%20Seeker/Authentication/sign_up.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'welcome.dart';

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
            () => Get.off( () => const Login())
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
