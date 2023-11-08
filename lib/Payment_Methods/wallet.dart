import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/Payment_Methods/add_bank_account_details.dart';
import 'package:flikka/controllers/SeekerEarningController/SeekerEarningController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
import '../res/components/request_timeout_widget.dart';
import '../res/components/server_error_widget.dart';
import '../res/components/unauthorised_request_widget.dart';
import 'request_withdraw.dart';


class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  // Initial Selected Value
  String? selectedValue;

  bool employee = true ;
  bool employer = false ;

  var requstedWitharwal ;

  // List of items in our dropdown menu
  var items = [
    'Latest',
    'Latest2',
    'Latest3',
    'Latest4',
    'Latest5',
  ];

  SeekerEarningController seekerEarningController = Get.put(SeekerEarningController()) ;

  final List<String> emails = ['johndue123@gmail.com', 'mailto:johndue124@gmail.com', 'mailto:johndue125@gmail.com',];
  final List<String> amount = <String>['342.00', '868.00', '456.00', ];
  final List<String> time = <String>['Today 10:40 AM', 'Today 10:40 AM', 'Today 10:40 AM', ];

  @override
  void initState() {
  seekerEarningController.seekerEarningApi() ;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (seekerEarningController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (seekerEarningController
              .error.value ==
              'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {},
            ),);
          } else if (seekerEarningController
              .error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {}),);
          } else if (seekerEarningController
              .error.value == "Internal server error") {
            return Scaffold(body: ServerErrorWidget(onPress: () {}),);
          } else if (seekerEarningController.
          error.value == "Unauthorised Request") {
            return Scaffold(body: UnauthorisedRequestWidget(onPress: () {}),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {}),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                 toolbarHeight: 40,
                leading: GestureDetector(
                    onTap: () {
                      Get.back() ;
                    },
                    child: Image.asset("assets/images/icon_back_blue.png")),
                title: Text("Wallet",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: Get.height * 0.01,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Earnings",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight
                                .w700, color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Get.to(() =>AddBankAccountDetails());
                          },
                          child: Text("Add bank account details",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor),
                              ),
                        ),
                      ],
                    ),
                     Text("How do I earn",
                       style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.blueThemeColor,fontWeight: FontWeight.w500,decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: Get.height * 0.02,),
                     Center(
                         child: Text("£ ${seekerEarningController.getEarningDetails.value.totalAmount ?? 0} ",
                             style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30,color: AppColors.blueThemeColor)
                         )
                     ),

                    SizedBox(height: Get.height * 0.035,),
                    Center(
                      child: MyButton(
                          title: "Request Withdraw", onTap1: () {
                            seekerEarningController.getEarningDetails.value.bankAccount ?
                        Get.to(() =>  const RequestWithdraw()) :
                           Utils.showMessageDialog(context, "Please add bank account details") ;
                      }),
                    ),
                    SizedBox(height: Get.height * 0.025,),
                    Center(
                      child: GestureDetector(
                      onTap: () {
                        _dialogBuilder(context);
                      },
                      child: Container(
                        height: Get.height*.075,
                        width: 295,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60)
                        ),
                        child: Text('See Referral Code', style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black)),),
                        ),
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('All Referral', style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                      SizedBox(width: Get.width * 0.18,),
                      const Text('Sort by', style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                      SizedBox(width: Get.width * 0.02,),
                      Container(
                        height: Get.height * 0.045,
                        width: Get.width * 0.27,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(60)),
                          border: Border.all(
                              width: 1, color: Colors.white),),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: items
                                .map((String item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },

                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                            ),

                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),)
                    ],),
                    const SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              employee = true ;
                              employer = false ;
                            });
                          },
                          child: Container(
                              height: 40,
                              width: 120,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                 color: employee ? AppColors.blueThemeColor : Color(0xff353535),
                              ),
                              child :  Text(
                                "Employee",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffFFFFFF),
                                ),
                              )
                          ),
                        ) ,
                        const SizedBox(width:20,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              employer = true ;
                              employee = false ;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                color: employer ? AppColors.blueThemeColor : Color(0xff353535),
                              ),
                            child :  Text(
                              "Employer",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffFFFFFF),
                                ),
                              )
                          ),
                        ) ,
                      ],
                    ) ,
                      const SizedBox(height: 20,),

                   Container(
                   child: employee ?   ListView.builder(
                     shrinkWrap: true,
                     physics: const BouncingScrollPhysics(),
                          itemCount: seekerEarningController.getEarningDetails.value.seeker?.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = seekerEarningController.getEarningDetails.value.seeker?[index] ;
                            String? formattedDate = formatDateTime(data?.createdAt);
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: Get.height * .1,
                              decoration: BoxDecoration(
                                color: const Color(0xff353535),
                                borderRadius: BorderRadius.circular(
                                    18),
                              ),
                              child: ListTile(
                                title: Text(
                                  "${data?.email}", style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),),
                                subtitle: Text(
                                  "$formattedDate", style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffCFCFCF)),),
                                trailing: const Text("View",
                                    style: TextStyle(fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff56B8F6))),
                              ),
                            );
                          }
                      ) :
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: seekerEarningController.getEarningDetails.value.recruiter?.length,
                            itemBuilder: (BuildContext context,
                                int index) {
                              var data = seekerEarningController.getEarningDetails.value.recruiter?[index] ;
                              String? formattedDate = formatDateTime(data?.createdAt);
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: Get.height * .1,
                                decoration: BoxDecoration(
                                  color: const Color(0xff353535),
                                  borderRadius: BorderRadius.circular(
                                      18),
                                ),
                                child: ListTile(
                                  title: Text(
                                    "${data?.email}", style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),),
                                  subtitle: Text(
                                    "$formattedDate", style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xffCFCFCF)),),
                                  trailing: const Text("View",
                                      style: TextStyle(fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff56B8F6))),
                                ),
                              );
                            }
                        ),
                   ),

                  ],),
                ),
              ),
            ),
          );
      }
    }
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          insetPadding: EdgeInsets.only(top: Get.height * .2,left: Get.width * .05 , right: Get.width * .05),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),),
            // height: Get.height*0.4,
            // width: Get.width*.3,
            child:  Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          // gradient: const LinearGradient(
                          //     colors: [
                          //       Color(0xff56B8F6),
                          //       Color(0xff4D6FED)
                          //     ],begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter
                          //
                          // ),
                          color: AppColors.blueThemeColor,
                          borderRadius: BorderRadius.circular(12),),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),),
                    )],),
                  SizedBox(height: Get.height*0.002,),
                  Container(
                    height: Get.height*0.33,
                    width: Get.width*1,
                    decoration: BoxDecoration(color: Color.fromRGBO(52, 52, 52, 1), borderRadius: BorderRadius.circular(12),),
                    child: Column(children: [
                      SizedBox(height: Get.height*0.03,),
                      const Text("Referral Code",style: TextStyle(fontSize: 22,fontWeight:   FontWeight.w700,color: Colors.white )),
                      SizedBox(height: Get.height*0.03,),
                      Container(
                        height: Get.height*0.06,
                        width: Get.width*0.65,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(69, 69, 69, 1),
                            borderRadius: BorderRadius.circular(60)
                        ),
                        child:  Center(
                          child: Text("${seekerEarningController.getEarningDetails.value.referralCode}",style: TextStyle(fontSize: 16,fontWeight:   FontWeight.w500,color: Colors.white )),
                        ),),
                      SizedBox(height: Get.height*0.03,),
                      GestureDetector(
                        onTap: () {
                          _copyToClipboard("${seekerEarningController.getEarningDetails.value.referralCode}") ;
                          Get.back() ;
                        },
                        child: Container(
                          height: Get.height*0.06,
                          width: Get.width*0.6,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              // gradient: const LinearGradient(
                              //     colors: [
                              //       Color(0xff56B8F6),
                              //       Color(0xff4D6FED)
                              //     ],begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter
                              //
                              // ),
                            color: AppColors.blueThemeColor,
                              borderRadius: BorderRadius.circular(60)
                          ),
                          child:  const Text('Copy',style: TextStyle(fontSize: 16,fontWeight:   FontWeight.w700,color: Colors.white )),),
                      )
                      //  Icon(Icons.close,color: Colors.white,),




                    ],),),
                ],
              ),
            ),

          ),
        );
      },
    );
  }

  void _copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    // Show a snackbar or any other feedback to inform the user that the text has been copied.
    ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        width: 200,
        content: Text('Text copied to clipboard'),
      ),
    );
  }

  String? formatDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        return 'today';
      } else if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
      } else {
        final months = difference.inDays ~/ 30;
        return '$months month${months > 1 ? 's' : ''} ago';
      }
    }
  }

}

