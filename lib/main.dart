
import 'package:flikka/Job%20Seeker/splash_screen.dart';
import 'package:flikka/hiring%20Manager/schedule_interview.dart';
import 'package:flikka/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


 void main() async {
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
      home: const ScheduleInterview()
    );
  }
}

