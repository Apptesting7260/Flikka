
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flikka/GlobalVariable/GlobalVariable.dart';
import 'package:flikka/controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import 'package:flikka/controllers/VerifyOtpController/VerifyOtpController.dart';
import 'package:flikka/data/network/base_api_Services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {



  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(
          const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> getApi2(String url)async{
SharedPreferences sp=await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson ;
    try {
      // print(BarrierTokenGet.toString());
      // print(BarrierTokenGet);
      final response = await http.get(Uri.parse(url),
        headers: {"Authorization":"Bearer ${sp.getString("BarrierToken")}"},

      ).timeout( const Duration(seconds: 30));
      responseJson  = returnResponse(response) ;
      
      print(response);

    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');

    }on TimeoutException {
      throw RequestTimeOut('');
}
    print(responseJson);
    return responseJson ;

  }




  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {

      final response = await http.post(Uri.parse(url),
        body: data,

      ).timeout(const Duration(seconds: 30));

      responseJson  = returnResponse(response) ;
print(response.body);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi2(var data , String url)async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson ;
    try {
      // print(BarrierToken.toString());
      print("object");
      final response = await http.post(Uri.parse(url),
          headers: {"Authorization":"Bearer ${sp.getString("BarrierToken")}"},
          body: data
      ).timeout( const Duration(seconds: 30));

      print("object");

   print(response);

      responseJson  = returnResponse(response) ;
    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');
    }on TimeoutException {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson ;

  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;

       String message=responseJson['message'].toString();
       print(message);
        return BadRequestException(message.toString()) ;

      default :
        throw FetchDataException('Error occoured while communicating with server '+response.statusCode.toString()) ;
    }
  }

}