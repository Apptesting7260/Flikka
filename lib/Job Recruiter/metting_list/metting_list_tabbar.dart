
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'past.dart';
import 'upcoming.dart';

class MettingListTabbar extends StatefulWidget {
  const MettingListTabbar({super.key});

  @override
  State<MettingListTabbar> createState() => _MettingListTabbarState();
}

class _MettingListTabbarState extends State<MettingListTabbar> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 50,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.0,top: 15),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
                child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,)),
          ),
          backgroundColor: Color(0xff000),
          title: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
                          'Meeting List',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
          ),
          bottom: TabBar(
            padding:  EdgeInsets.only(right: Get.width*.53),
            indicatorPadding: EdgeInsets.only(left: Get.width*.04),
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0,color: Color(0xff56B8F6)),
              //insets: EdgeInsets.symmetric(horizontal: width*.14),
            ),
            physics: AlwaysScrollableScrollPhysics(),
            unselectedLabelColor: Color(0xffCFCFCF),
            labelColor: Color(0xff56B8F6),
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),

            tabs: const [
              Tab(text: "UPCOMING"),
              Tab(text: "PAST",),
            ],
          ),
        ),
          body: TabBarView(
            children: [
              Upcoming(),
              Past(),
            ],
          ),
        ),
      ),
    );
  }
}
