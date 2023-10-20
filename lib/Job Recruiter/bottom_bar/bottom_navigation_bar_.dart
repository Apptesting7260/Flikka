import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomEmployer extends StatefulWidget {
  final int bottomSelectedIndex;
  final Function bottomTapped;

  const BottomEmployer(
      {Key? key, required this.bottomSelectedIndex, required this.bottomTapped})
      : super(key: key);

  @override
  _BottomEmployerState createState() => _BottomEmployerState();
}

class _BottomEmployerState extends State<BottomEmployer> {
  List<BottomNavigationBarItem> buildBottomNavBarItems = [
    BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_home.svg",height: Get.height*.024,),
        activeIcon: SvgPicture.asset("assets/images/icon_select_home.svg",height: Get.height*.024)),


    BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_applicant.svg",height: Get.height*.024),
        activeIcon: SvgPicture.asset("assets/images/icon_select_applicant.svg",height: Get.height*.024)
    ),


    BottomNavigationBarItem(
      label: "",
      icon: SvgPicture.asset("assets/images/icon_Add_job.svg",height: Get.height*.055),
      activeIcon: SvgPicture.asset("assets/images/icon_Add_job.svg",height: Get.height*.055),
    ),

    BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_msg.svg",height: Get.height*.024),
        activeIcon: SvgPicture.asset("assets/images/icon_select_msg.svg",height: Get.height*.024)
    ),

    BottomNavigationBarItem(
      label: "",
      icon: SvgPicture.asset("assets/images/icon_unselect_person.svg",height: Get.height*.024),
      activeIcon: SvgPicture.asset("assets/images/icon_select_person.svg",height: Get.height*.024),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25), // Adjust the radius as needed
        topRight: Radius.circular(24), // Adjust the radius as needed
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: buildBottomNavBarItems,
        selectedItemColor: const Color(0xff56B8F6),
        unselectedItemColor: Color(0xffC4C4C4),
        selectedIconTheme: const IconThemeData(
          color: const Color(0xff56B8F6),
        ),
        unselectedIconTheme: const IconThemeData(
          color: const Color(0xffC4C4C4),
        ),

        elevation: 8,
        backgroundColor: Color(0xff353535),
        currentIndex: widget.bottomSelectedIndex,
        onTap: (index) => widget.bottomTapped(index),
        selectedFontSize: 12,
        unselectedFontSize: 10,
      ),
    );
  }
}
