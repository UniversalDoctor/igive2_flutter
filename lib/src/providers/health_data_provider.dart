import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:igive2/src/app_config.dart';
import 'package:igive2/src/utils/session_token.dart';

class HealthDataProvider{
  final _session = SessionToken();

  // POST health data
  Future sendHealthData(String type, String data) async{
    final token = await getAccessToken();
    final bodyData = {
      "data": type,
      "notes": "no hay notas",
      "value": data
    };
    final resp = await http.post(
      '${AppConfig.apiHost}/mobile/healthData',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
      body: jsonEncode(bodyData)
    );

    if(resp.statusCode == 200){
      return{'ok': true};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }


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
}