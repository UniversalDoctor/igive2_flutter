import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/app_config.dart';
import 'package:igive2/src/utils/session_token.dart';

class StatisticsProvider{
  final _session = SessionToken();

  //GET TOKEN AND REFRESH IT
  Future<String> getAccessToken() async{
    try{
      final result = await _session.get();
      if(result != null){
        final token = result['token'] as String;
        return token;
      }else{
        return null;
      }
    }on PlatformException catch (error){
      return null;
    }
  }

  // GET ALL DATA
  Future getAllData() async{
    final token = await getAccessToken();
    final result = await http.get(
      '${AppConfig.apiHost}/mobile/healthData',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()}
    );

    if(result.statusCode == 200){
      List decodeResp = json.decode(result.body);
      return{'ok': true, 'info': decodeResp};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //GET ALL DATA of datatype
  Future getAllDataOfDatatype(String dataType, String dateFrom, String dateTo) async{
    final token = await getAccessToken();
    final body = {
      "data": dataType,
      "dateGT": dateFrom,
      "dateLT": dateTo
    };
    final result = await http.post(
      '${AppConfig.apiHost}/mobile/healthData/dataBetween',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
      body: json.encode(body)
    );

    // Uri uri = Uri.parse('${AppConfig.apiHost}/mobile/healthData/dataBetween');
    // final newURI = uri.replace(queryParameters: body);
    // final result = await http.post(
    //   newURI,
    //   headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    // );


    if(result.statusCode == 200){
      List decodeResp = json.decode(result.body);
      return{'ok': true, 'info': decodeResp};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

}