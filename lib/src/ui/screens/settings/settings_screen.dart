import 'package:flutter/material.dart';
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/translations.dart';

class SettingsScreen extends StatefulWidget {

  static const String routeName = '/settings';
  @override
  _SettingsScreenState createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitched = false;
  final _usersProvider = UsersProvider();
  final _prefs = UserPreferences();
  bool _isLoading = true;
  TextStyle _buttonText = TextStyle(fontSize: 17, color: Colors.white);

  @override
  void initState(){
    this._getNotifications();
    super.initState();
  }

  Future _getNotifications() async{
    bool notifications = false;
    await _prefs.initPrefs();
      if(_prefs.activeNotifications != null){
        notifications = _prefs.activeNotifications;
      }
      setState(() {
        isSwitched = notifications;
        _isLoading = false;
      });
  }
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          AppBackground(),
          _isLoading ? 
           Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) :
          Center(
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width < 350 ? 20.0 : 60.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(_translate('settings_title'), style: TextStyle(fontSize: 30.0, letterSpacing: 5.0, fontFamily: 'MontserratBold'), ),
                        ),
                        SizedBox(height: 40.0),
                        AppButton(
                          color: Colors.black38,
                          name: _translate('settings_edit_profile_btn'),
                          textStyle: _buttonText,
                          onPressed: () => Navigator.pushNamed(context, '/editprofile'),
                        ),
                        SizedBox(height: 10.0),
                        AppButton(
                          color: Colors.black38,
                          name: _translate('settings_setup_btn'),
                          textStyle: _buttonText,
                          onPressed: () => Navigator.pushNamed(context, '/setup')
                        ),
                        SizedBox(height: 10.0),
                        AppButton(
                          color: Colors.black38,
                          name: _translate('terms_conditions_title'),
                          textStyle: _buttonText,
                          onPressed: () => Navigator.pushNamed(context, '/termsconditions'),
                        ),
                        SizedBox(height: 10.0),
                        AppButton(
                          color: Colors.black38,
                          name: _translate('settings_igive_btn'),
                          textStyle: _buttonText,
                          onPressed: (){},
                          // onPressed: () => Navigator.pushNamed(context, '/behind'),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(_translate('settings_notifications'), style: TextStyle(fontSize: 17),),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) async{
                                setState(() {
                                  isSwitched = value;
                                });

                                Map newsletterInfo = await _usersProvider.newsletter(value);

                                if(newsletterInfo['ok']){
                                  _prefs.activeNotifications = value;
                                  
                                }else{
                                  setState(() {
                                    isSwitched = !value;
                                  });
                                  _scaffoldKey.currentState.showSnackBar(
                                    _showSnackBar(_translate(newsletterInfo['message']))
                                  );
                                }
                              },
                              activeTrackColor: Colors.blue[200],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        AppButton(
                          color: Colors.red[200],
                          name: _translate('logout_btn'),
                          textStyle: _buttonText,
                          onPressed: () async{
                            await _usersProvider.logout();
                            Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  Widget _showSnackBar(translation){
      return SnackBar(
        duration: Duration(seconds: 2),
        content: Container(
          height: 40.0,
          child: Center(child: Text(translation, style: TextStyle(color: Color(0xffff9292)))),
        ),
    );
  }
}