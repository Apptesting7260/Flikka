import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'SeekerForumDataController.dart';

class ForumAddCommentController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  SeekerForumDataController forumDataController = Get.put(SeekerForumDataController()) ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void seekerAddComment( BuildContext context , String? forumID , String? comment ,){
    loading(true) ;
    var data = {} ;
    data.addIf(forumID != null && forumID.length != 0 , "forum_id" , forumID?.toLowerCase()) ;
    data.addIf(comment != null && comment.length != 0 , "comment" , comment?.toLowerCase()) ;

    setRxRequestStatus(Status.LOADING);
    _api.forumAddComment(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      Get.back() ;
      forumDataController.seekerForumListApi() ;
      loading(false) ;
      if (kDebugMode) {
        print(value);
      }}
    ).onError((error, stackTrace){
      loading(false) ;
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      Utils.showMessageDialog(context, "oops! something went wrong") ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}