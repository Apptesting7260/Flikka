
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';

class SeekerPostReviewController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  postReview( String? recruiterID , String? review , String? rating) async{
    loading(true) ;
    var data =  {};

    data.addIf(recruiterID != null && recruiterID.length != 0 , 'recruiter_id' , "$recruiterID" ) ;
    data.addIf(review != null && review.length != 0 , 'discription' , "$review" ) ;
    data.addIf(rating != null && rating.length != 0 , 'stars' , "$rating" ) ;

    _api.seekerPostReview(data).then((value){
      loading(false) ;
      if(value.status!){
        Get.back() ;
        Utils.toastMessage('Post saved') ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      // Get.back() ;
    }) ;
  }
}