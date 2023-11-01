
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/my_button.dart';

class CommonFunctions {

  static showLoadingDialog(BuildContext context , String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator( color: AppColors.blueThemeColor,)) ,
                    SizedBox(width: Get.width*.1,),
                    Text("$message...",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),) ,
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  static confirmationDialog (BuildContext context , { required String message , required  Function() onTap } ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                      MyButton(
                        width: Get.width*.25,
                        height: Get.height*.05,
                        // loading: loading,
                        title: "Yes",
                        onTap1: onTap ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "No",
                    onTap1: () { Get.back() ;},)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static downloadFile(String fileUrl, String fileName, String savedDir) async {
    final taskId = await FlutterDownloader.enqueue(
      url: fileUrl,
      savedDir: savedDir,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

}
