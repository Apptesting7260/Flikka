
import 'package:flikka/Job%20Seeker/Authentication/user/user_profile.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../SeekerFilter/filter_page.dart';
import '../SeekerHome/find_job_home_page.dart';
import '../location.dart';
import '../saved_post_widget.dart';
import '../search_job.dart';


class TabScreen extends StatefulWidget {
  final int index;

  const TabScreen({Key? key, required this.index}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int? bottomSelectedIndex;
  PageController? pageController;
  DateTime currentBackPressTime = DateTime.now();
  bool loading = false;
  var data;
  final drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // fetchApi();

    bottomSelectedIndex = widget.index;
    pageController = PageController(initialPage: widget.index, keepPage: true);

    super.initState();
    // studentType = MySharedPreferences.localStorage?.getString(MySharedPreferences.studentType) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => pageChanged(index),
            children: const [
              FindJobHomeScreen(),
              Location(),
              SearchJob(),
              MessagePage(),
              UserProfile(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(
        bottomSelectedIndex: bottomSelectedIndex!,
        bottomTapped: bottomTapped,
      ),
    );
  }

  void bottomTapped(int index) {
    setState(
          () {
        bottomSelectedIndex = index;
        pageController!.animateToPage(index,
            duration: const Duration(microseconds: 1), curve: Curves.ease);
      },
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  Future<bool> _onWillPop() {
    if (bottomSelectedIndex != 1) {
      setState(
            () {
          pageController!.jumpTo(0);
        },
      );
      return Future.value(false);
    } else if (bottomSelectedIndex == 1) {
      setState(
            () {
          pageController!.jumpTo(1);
        },
      );
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(milliseconds: 500)) {
      currentBackPressTime = now;
      SystemNavigator.pop();
      return Future.value(false);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(true);
  }

  goAtLikeTab() {
    pageController!.animateToPage(1,
        duration: const Duration(microseconds: 1), curve: Curves.ease);
  }
}
