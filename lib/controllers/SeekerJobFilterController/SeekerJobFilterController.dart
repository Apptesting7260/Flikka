
import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';

class SeekerJobFilterController extends GetxController {

  final _api = SeekerRepository();

  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  var jobsData = GetJobsListingModel().obs ;

  void filterJob(
      dynamic jobTitle ,
      dynamic location ,
      dynamic company ,
      dynamic datePosted ,
      dynamic typeOfWorkplace ,
      dynamic minSalaryExpectation ,
      dynamic maxSalaryExpectation ,
      dynamic employmentType ,
      dynamic qualification ,
      dynamic skills ,
      dynamic language ,
      ) async{
    loading.value = true ;

    Map data = {
      'job_title' : jobTitle.toString(),
      "location" : location.toString(),
      "company" : company.toString(),
      "date_posted" : datePosted.toString(),
      "type_of_workplace" : typeOfWorkplace.toString(),
      "min_salary_expectation" : minSalaryExpectation.toString(),
      "max_salary_expectation" : maxSalaryExpectation.toString(),
      "employment_type" : employmentType.toString(),
      "qualification" : qualification.toString(),
      "sales_skills" : skills.toString(),
      "language" : language.toString(),
    };
    print(data);

    _api.seekerJobFilterApi(data).then((value){
      loading.value = false ;
      if(value.status!){
      jobsData(value) ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Utils.toastMessage( "${value.message}") ;
        Get.back() ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;

    });
  }
}