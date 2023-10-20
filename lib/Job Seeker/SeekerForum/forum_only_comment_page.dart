import 'package:flikka/Job%20Seeker/SeekerForum/add_new_forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';

class ForumOnlyCommentPage extends StatefulWidget {
  const ForumOnlyCommentPage({super.key});

  @override
  State<ForumOnlyCommentPage> createState() => _ForumOnlyCommentPageState();
}

class _ForumOnlyCommentPageState extends State<ForumOnlyCommentPage> {
  TextEditingController commentController = TextEditingController();
  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a Comment",style: Theme.of(context).textTheme.displayLarge,),
          content: TextField(
            style: TextStyle(
                color: AppColors.white,fontSize: 23
            ),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 15.0),
      //     child: Image.asset('assets/images/backicon.png'),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.black,
      //   title: Text("Forum",style: Get.theme.textTheme.displayLarge),
      // ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
        child:
        ListView(
          children: [
            Row(
              children: [
                SizedBox(height: Get.height*.01,),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                    child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)),
                SizedBox(width: Get.width*.04,),
                Text("Forum",style: Get.theme.textTheme.displayLarge),
              ],
            ),
            SizedBox(height: Get.height*.02,),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                ),
                SizedBox(
                  width: Get.width * 0.015,
                ),
                Container(
                    height: Get.height*0.06,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=>AddNewForum());
                      },
                        child: Image.asset('assets/images/icon_add_form.png',fit: BoxFit.cover,))),
              ],
            ),
            SizedBox(
              height: Get.height * 0.035,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff353535),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage('https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lorem Ipsum is simply",
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),softWrap: true,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.005,
                                  ),
                                  Text(
                                    "Jessica Parker",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.035,
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.ratingcommenttextcolor,
                        letterSpacing: 0.01,
                      ),
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.ratingcommenttextcolor,
                        letterSpacing: 0.01,
                      ),
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.ratingcommenttextcolor,
                        letterSpacing: 0.01,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                           Image.asset("assets/images/icon_watch.png",height: Get.height*.02,),
                            SizedBox(width: Get.width*.015,),
                            Text("10:20 PM",style: Get.theme.textTheme.bodySmall!.copyWith(color:Color(0xffAFAFAF),fontSize: 10),),
                          ],
                        ),
                        SizedBox(
                          width: Get.width * 0.035,
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/icon_calendar.png",height: Get.height*.02,),
                            SizedBox(width: Get.width*.015,),
                            Text("20 Mar, 2023",style: Get.theme.textTheme.bodySmall!.copyWith(color:Color(0xffAFAFAF),fontSize: 10),),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Color(0xffCFCFCF),

                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Text("Comment",style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Container(
                      height: Get.height*0.24,
                      child: ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context,index){
                          return Padding(
                            padding:  EdgeInsets.symmetric(vertical: Get.height*.01),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage('https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',),
                              ),
                              title: RichText(text: TextSpan(
                                text: "John Due",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                                children: [
                                  TextSpan(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)))
                                ]
                              ),),
                              subtitle: Row(
                                children: [
                                  Text("3 hrs ago",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                  SizedBox(width: Get.width*.04,),
                                  Text("Reply",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10,fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),)
                                ],
                              ),
                            ),
                          );
                        // return Padding(
                        //   padding: const EdgeInsets.only(bottom: 10.0),
                        //   child: Row(
                        //     children: [
                        //       CircleAvatar(
                        //         radius: 30,
                        //         backgroundImage: NetworkImage('https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',),
                        //       ),
                        //       Column(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.only(left: 10),
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   "Lorem Ipsum is simply",
                        //                   style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),softWrap: true,
                        //                 ),
                        //                 SizedBox(
                        //                   height: Get.height * 0.005,
                        //                 ),
                        //                 Text(
                        //                   "Jessica Parker",
                        //                   style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // );
                      }),
                    ),
                    SizedBox(
                      height: Get.height *.01,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(color: AppColors.white),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(color: Color(0xff454545))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(color: Color(0xff454545))
                                ),
                                filled: true,fillColor: Color(0xff454545),
                                hintStyle: Get.theme.textTheme.bodyMedium,
                                hintText: 'Type...'
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width*.025,),
                        Image.asset("assets/images/icon_Send_msg.png",height: Get.height*.055,)
                      ],
                    ),
                    SizedBox(
                      height: Get.height *.08,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}


