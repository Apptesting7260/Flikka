
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import 'package:flikka/Job%20Seeker/Authentication/user/create-profile.dart';
import 'package:flikka/Job%20Seeker/splash_screen.dart';
import 'package:flikka/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Job Recruiter/AddJobPage/add_a_job_page_area.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
//////////////////////////////////////////////
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flikka',
      theme: MyTheme.dark,
      home: const SplashScreen()
    );
  }
}

