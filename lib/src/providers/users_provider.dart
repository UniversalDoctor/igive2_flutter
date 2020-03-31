import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/app_config.dart';
import 'package:igive2/src/utils/session_token.dart';

class UsersProvider{
  
  final _prefs = new UserPreferences();
  final _session = SessionToken();


  // LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async{
    final authData = {
      'username': email,
      'password': password,
    };

    final resp = await http.post(
      '${AppConfig.apiHost}/mobile/authenticate',
      headers: {'content-type': 'application/json'},
      body: json.encode(authData)
    );

    print(resp.statusCode);
    if(resp.statusCode == 200){

      Map<String, dynamic> decodeResp = json.decode(resp.body);

      final token = decodeResp['id_token'] as String;
      await _session.set(token);

      return {'ok': true};
    } else if(resp.statusCode == 401){
      Map<String, dynamic> decodeResp = json.decode(resp.body);
      if(decodeResp['detail'] == 'Bad credentials'){
        return {'ok': false, 'message': 'login_alert_body'};
      }else if(decodeResp['detail'].contains('not activated')){
        return {'ok': false, 'message': 'login_alert_verify'};
      }else{
        //TODO:: if the same email as dashboard
        return{'ok': false, 'message': 'not_working_body'};
      }
    }else{
      return {'ok': false, 'message': 'not_working_body'};
    }
  }

  // GET PROFILE / SET PROFILE
  Future getProfile() async{
    final token = await getAccessToken();
    final resp = await http.get(
      '${AppConfig.apiHost}/mobile/profile/mobileUser?',
      headers: {'Authorization': 'Bearer ' + token.toString()}
    );

    if(resp.statusCode == 200){
      Map decodeResp = json.decode(resp.body);
      return {'ok': true, 'info': decodeResp};
    }else{
      logout();
      return {'ok': false, 'message': 'something_is_broke'};
    }
  }

  //GET setup
  Future getSetup() async{
    final token = await getAccessToken();
    final resp = await http.get(
      '${AppConfig.apiHost}/mobile/profile/info',
      headers: {'Authorization': 'Bearer ' + token.toString()}
    );

    if(resp.statusCode == 200){
      Map decodeResp = json.decode(resp.body);
      return{'ok': true, 'info': decodeResp};
    }else{
      return{'ok': false, 'message': 'something_is_broke'};
    }
  }

  //LOGOUT
  Future logout() async{
    // _prefs.token = '';
    _session.clear();
  }


  //REGISTER
  Future signup(String email, String firstName, String lastName, String password, String langKey, bool newsletter) async{
    final authData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "langKey": 'en',
      "login": email,
      "password": password
    };

    final resp = await http.post(
      '${AppConfig.apiHost}/mobile/register/'+newsletter.toString(),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(authData)
    );

    if(resp.statusCode != null){
      if(resp.statusCode >= 400 && resp.statusCode < 500){
        Map<String, dynamic> decodeResp = json.decode(resp.body);
        return{'ok':false, 'errorKey': decodeResp['errorKey']};
      }else if(resp.statusCode >=500){
        return{'ok':false};
      }else{
        return{'ok':true, 'statusCode': resp.statusCode};
      }
    }
  }

  //RESET PASSWORD
  Future resetPassword(String email) async{
    final resp = await http.post(
      '${AppConfig.apiHost}/account/reset-password/init',
      body: email
    );

    if(resp.statusCode != null){
      if(resp.statusCode == 200){
        return{'ok': true};
      }else{
        return{'ok': false, 'message': 'wrong_email'};
      }
    }else{
      return {'ok': false, 'message': 'something_is_broke'};
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

  //CHANGE newsletter
  Future newsletter(bool newsletter) async{

    final token = await getAccessToken();
    final result = await http.put(
      '${AppConfig.apiHost}/mobile/profile/$newsletter',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer '+token.toString()},
    );

    if(result.statusCode == 200){
      return{'ok': true};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //PUT setup
  Future setup(String gender, String birthdate, String height, String weight, String country, String disease) async{
    final data = {
      "country": country,
      "gender": gender,
      "birthdate": birthdate,
      "diseases": disease,
      "weight": weight,
      "height": height
    };

    final token = await getAccessToken();
    final result = await http.put(
      '${AppConfig.apiHost}/mobile/profile/setUp',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer '+token.toString()},
      body: jsonEncode(data)
    );

    if(result.statusCode == 200){
      return{'ok':true};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //POST hypertension
  Future postHypertension(String sistolic, String dyastolic) async{

    final data = {
      "systolic": sistolic,
      "dyastolic": dyastolic,
    };

    final token = await getAccessToken();
    final result = await http.post(
      '${AppConfig.apiHost}/mobile/healthData/hypertension',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
      body: jsonEncode(data)
    );


    if(result.statusCode == 200){
      return{'ok': true};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }

  //DELETE user
  Future deleteUser() async{
    final token = await getAccessToken();
    final result = await http.delete(
      '${AppConfig.apiHost}/mobile/profile',
      headers: {'content-type': 'application/json', 'Authorization': 'Bearer ' + token.toString()},
    );

    if(result.statusCode == 200){
      logout();
      return{'ok': true};
    }else{
      return{'ok': false, 'message': 'not_working_body'};
    }
  }
}
