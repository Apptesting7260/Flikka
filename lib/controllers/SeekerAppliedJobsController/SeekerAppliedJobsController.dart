import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:get/get.dart';
import '../../models/SeekerSavedPostModel/SeekerSavedPostModel.dart';


class SeekerAppliedJobsController extends GetxController {

  final _api = SeekerRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final jobsList = SeekerSavedJobsListModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> getJobsApi() async {
    setRxRequestStatus(Status.LOADING);
    _api.appliedJobsApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      jobsList(value);
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());

      setRxRequestStatus(Status.ERROR);

    });
  }

  // filterList(String? query) {
  //   companies?.value = getCompaniesList.value.companyList!.where((element) =>
  //       element.companyName!.toLowerCase().contains(query!.toLowerCase())).toList()
  // }

}