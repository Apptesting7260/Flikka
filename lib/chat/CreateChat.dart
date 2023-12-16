import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/Job%20Seeker/SeekerHome/home_swiper_find_job_widget.dart';
import 'package:flikka/controllers/GetJobsListingController/GetJobsListingController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? RecruiterId;
String ?SeekerID;
class Ctreatechat{
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final ViewSeekerProfileController ViewSeekerProfileControllerinstance=ViewSeekerProfileController();
  GetJobsListingController getJobsListingController = GetJobsListingController() ;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CreateChat()async{
 Map <String, dynamic> roomdetails = {};
      Map <String, dynamic> roomdetailsmaker = {};
      SharedPreferences sp = await SharedPreferences.getInstance() ;
print( RecruiterId);
print( Recruitername);
print( Recruiterimg);
     

      // print(_firestore.collection(value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString()).get().toString());


Future<bool> doesDocumentExistSeeker(String collectionPath, String documentPath) async {
  final documentReference = FirebaseFirestore.instance.collection("S-ID"+sp.getString("seekerID")!).doc("GPR"+RecruiterId.toString()+ sp.getString("seekerID")!);
  final snapshot = await documentReference.get();

  return snapshot.exists;
}
Future<bool> doesDocumentExistRecruter(String collectionPath, String documentPath) async {
  final documentReference = FirebaseFirestore.instance.collection("R-ID"+RecruiterId.toString()).doc("GPR"+RecruiterId.toString()+sp.getString("seekerID")!);
  final snapshot = await documentReference.get();

  return snapshot.exists;
}


final SeekercollectionPath = "S-ID"+sp.getString("seekerID").toString();
final SeekerdocumentPath ="GPR"+RecruiterId.toString()+ sp.getString("seekerID")!;
final Seekerexists = await doesDocumentExistSeeker(SeekercollectionPath, SeekerdocumentPath);


final RecruitercollectionPath = "R-ID"+RecruiterId.toString();
final RecruiterdocumentPath ="GPR"+RecruiterId.toString()+sp.getString("seekerID")!;
final Recruiterexists = await doesDocumentExistSeeker(RecruitercollectionPath, RecruiterdocumentPath);

if (Seekerexists) {
  // Seeker document exists
} else {
    roomdetails = {
          "SeekerName":sp.getString("seekerName") ,
          "SeekerId": sp.getString("seekerID"),
          "RoomID": "GPR"+RecruiterId.toString()+sp.getString("seekerID")!,
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":sp.getString("seekerProfileImg"),
       };
         await _firestore.collection("S-ID"+sp.getString("seekerID")!,).doc("GPR"+RecruiterId.toString()+sp.getString("seekerID")!,).set(roomdetails);
  // Seeker document does not exist
}

if (Recruiterexists) {
  // Recruiter document exists
} else {
    roomdetails = {
           "SeekerName":sp.getString("seekerName") ,
          "SeekerId": sp.getString("seekerID"),
          "RoomID": "GPR"+RecruiterId.toString()+sp.getString("seekerID")!,
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":sp.getString("seekerProfileImg")!
       };
         await _firestore.collection("R-ID"+RecruiterId.toString(),).doc("GPR"+RecruiterId.toString()+sp.getString("seekerID")!,).set(roomdetails);
  // Seeker document does not exist
}

  // Recruiter document does not exist
}

}