import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 20);
    token = sharedPreferences.getString(AppConstants.storedToken)??'';
    allowAutoSignedCert = true;
    _mainHeaders = {
      'Context-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Context-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async{
    try{

      Response response = await get(Uri.encodeFull(uri), headers: headers??_mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{

    try{
      Response response = await post(uri, jsonEncode(body), headers: _mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body) async{
    try{
      Response response = await put(uri, jsonEncode(body), headers: _mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchData(String uri, dynamic body) async{
    try{
      Response response = await patch(uri, jsonEncode(body), headers: _mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}