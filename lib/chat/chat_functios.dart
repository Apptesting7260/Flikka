import 'package:cloud_firestore/cloud_firestore.dart';


class MsgFunction{



///////////////CHATROOM FUNCTIONS///////////////////////
selfchatroom(){

  
}

////////////////MESSAGESING FUNCTIONS////////////////////////////

SendMsgToRecruiter(String msg,String myidchat,String roomid, Map<String, dynamic> messages)async{

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference roomRef1 = _firestore.collection("s"+myidchat).doc(roomid);

           await roomRef1.update({
      'timestamp': FieldValue.serverTimestamp(),
      "lastmsg": msg,

      // Add other room metadata if needed
    });

     await _firestore
            .collection("s"+myidchat)
            .doc(roomid)
            .collection("massages")
            .add(messages);
            print("mysendersusscess");

}


SendMsgToSeeker(String msg,String anotherseeker,String roomid,  Map<String, dynamic> messages)async{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference roomRef1 = _firestore.collection("s"+anotherseeker).doc(roomid);

           await roomRef1.update({
      'timestamp': FieldValue.serverTimestamp(),
      "lastmsg": msg,

      // Add other room metadata if needed
    });
 
     await _firestore
            .collection("s"+anotherseeker)
            .doc(roomid)
            .collection("massages")
            .add(messages);
            print("anothersendersusscess");

}


// Makersender(String msg,String maker,String roomid,  Map<String, dynamic> messages)async{

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   DocumentReference roomRef1 = _firestore.collection("m"+maker).doc(roomid);

//            await roomRef1.update({
//       'timestamp': FieldValue.serverTimestamp(),
//       "lastmsg": msg,

//       // Add other room metadata if needed
//     });
 
//      await _firestore
//             .collection("m"+maker )
//             .doc(roomid)
//             .collection("massages")
//             .add(messages);
//             print("anothersendersusscess");

// }






}