library splashscreen;
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _sysLng = ui.window.locale.languageCode;
  final _prefs = new UserPreferences();
  final _usersProvider = UsersProvider();


  @override
  void initState(){
    super.initState();
    _checkSystemLang();
    this.checkToken();
  }

  checkToken() async{
    final token = await _usersProvider.getAccessToken();

    if(token != null){
      Map setupInfo = await _usersProvider.getSetup();
      if(setupInfo['ok']){
        _prefs.studies = setupInfo['info']['numberStudies'];
        if(setupInfo['info']['country'] != null && setupInfo['info']['gender'] != null && setupInfo['info']['birthdate'] != null && setupInfo['info']['diseases'] != null && setupInfo['info']['weight'] != null && setupInfo['info']['height'] != null){
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> r) => false);
          // if(setupInfo['info']['numberStudies'] != 0){
          //   Navigator.pushNamedAndRemoveUntil(context, '/communitystudy', (Route<dynamic> r) => false);
          // }else{
          //   //TODO:: cambiar
          //   Navigator.pushNamedAndRemoveUntil(context, '/statistics', (Route<dynamic> r) => false);
          // }
        }else{
          Navigator.pushNamedAndRemoveUntil(context, '/setup', (Route<dynamic> r) => false);
        }
      }else{
        Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
      }
    }else{
        Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
    }
  }

  Future _checkSystemLang() async{
    _prefs.systemLang = _sysLng;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AppBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}