import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchJob extends StatefulWidget {
  const SearchJob({Key? key}) : super(key: key);

  @override
  State<SearchJob> createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
          child: Column(
             children: [
               Row(
                 children: [
                   SizedBox(height: Get.height*.12,),
                   // Align(
                   //     alignment: Alignment.topLeft,
                   //     child: InkWell(
                   //         onTap: () {
                   //           Get.back();
                   //         },
                   //         child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,))),
                   SizedBox(width: Get.width*.04,),
                   Text("Search",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                 ],
               ),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.008),
                 decoration: BoxDecoration(
                   color: Color(0xff373737),
                   borderRadius: BorderRadius.circular(33.0),
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.search, color: Color(0xff56B8F6),size: 30,),
                     SizedBox(width: Get.width*.03),
                     Expanded(
                       child: TextFormField(
                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                         onChanged: (query){
                           // filterPositionNames(query);
                         },
                         decoration: InputDecoration(
                           hintText: 'Search',
                           hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                           border: InputBorder.none,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
          ),
        ),
      ),
    );
  }
}
