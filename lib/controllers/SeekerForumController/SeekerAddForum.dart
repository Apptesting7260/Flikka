import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerForumDataModel/SeekerForumDataModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SeekerAddForumController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void seekerAddForum( BuildContext context , {String? industryID}){
    var data = {} ;
    data.addIf(industryID != null && industryID.length != 0 , "industry_id" , industryID?.toLowerCase()) ;

    setRxRequestStatus(Status.LOADING);
    _api.seekerForumData(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace){
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