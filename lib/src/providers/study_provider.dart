import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/app_config.dart';
import 'package:igive2/src/utils/session_token.dart';

class StudyProvider{
  
  final _prefs = new UserPreferences();
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

  // ADD study
  Future addStudy(String code) async{
    final token = await getAccessToken();
    final result = await http.post(
      '${AppConfig.apiHost}/mobile/study/$code',
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ' + token.toString()
      },
    );

    if(result.statusCode == 200){
      Map decodeResp = json.decode(result.body);
      return{'ok': true, 'info': decodeResp};
    }else if(result.statusCode == 404 || result.statusCode == 401){
      return{'ok': false, 'message': 'study_not_found'};
    }else if(result.statusCode == 208){
      return{'ok': false, 'message': 'study_already_reported'};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }
  // LEAVE study
  Future leaveStudy(String participantId) async{
    final token = await getAccessToken();
    final result = await http.delete(
      '${AppConfig.apiHost}/mobile/study/$participantId',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    );
    if(result.statusCode == 200){
      return{'ok': true};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //SEND questionnaire
  Future sendQuestionnaire(Map questions) async{
    final token = await getAccessToken();
    final result = await http.post(
      '${AppConfig.apiHost}/mobile/participantAnswers',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
      body: jsonEncode(questions)
    );
    if(result.statusCode == 200){
      return{'ok': true};
    } else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  
  //get study by code
  Future getStudyInfo(String code) async{
    final token = await getAccessToken();
    final result = await http.get(
      '${AppConfig.apiHost}/mobile/studyInfo/$code',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    );

    if(result.statusCode == 200){
      Map decodeResp = json.decode(result.body);

      return{'ok': true, 'message': decodeResp};
    }else if(result.statusCode == 409 ){
      return{'ok': false, 'message': 'invalid_code'};
    }else if(result.statusCode == 401){
      return{'ok': false, 'message': 'invalid_invitation'};
    }else if(result.statusCode == 208){
      return{'ok': false, 'message': 'study_already_reported'};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //GET studies
  Future getStudies() async{
    final token = await getAccessToken();
    final result = await http.get(
      '${AppConfig.apiHost}/mobile/study',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    );

    if(result.statusCode == 200){
      List decodeResp = json.decode(result.body);
      return{'ok': true, 'info': decodeResp};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //get study details
  Future getStudyDetails(String studyId) async{
    final token = await getAccessToken();
    final result = await http.get(
      '${AppConfig.apiHost}/mobile/studyCompletedForms/$studyId',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    );

    if(result.statusCode == 200){
      Map decodeResp = json.decode(result.body);

      return{'ok': true, 'info': decodeResp};
    }else {
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //GET questionnaire
  Future getQuestionnaire(String idForm) async{
    final token = await getAccessToken();
    final result = await http.get(
      '${AppConfig.apiHost}/mobile/studyForms/$idForm',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    );

    if(result.statusCode == 200){
      print(json.decode(result.body));
      Map decodeResp = json.decode(result.body);
      return{'ok': true, 'info': decodeResp};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }
}
