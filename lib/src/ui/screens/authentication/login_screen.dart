import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/bloc/login_bloc.dart';
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/app_icon.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/translations.dart';

class LoginScreen extends StatefulWidget {

  static const String routeName = '/login';
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _focusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final usersProvider = UsersProvider();
  bool _isLoading = false;
  final bloc = Provider.loginBloc();
  final _prefs = new UserPreferences();
  


  @override
  void initState() {
    super.initState();
    bloc.resetControllers();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            Center(
              child: Container(
                child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width < 350 ? 30.0 : 60.0),
                      child: SafeArea(
                        child: Form(
                          key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Container(
                                  // color: Colors.green,
                                  AppIcon(size: 200.0),
                                // ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _translate('login_title'),
                                        style: TextStyle(
                                          fontFamily: 'MontserratExtraBold',
                                          fontSize: 18.0
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          border: Border(right: BorderSide(color: Colors.white, width: 1.0))
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          border: Border(left: BorderSide(color: Colors.white, width: 1.0))
                                        ),
                                      ),
                                      _registerButton()
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        _translate('form_email'), 
                                        style: TextStyle(fontSize: 17.0)),
                                      SizedBox(height: 5.0,),
                                      _emailField(bloc),
                                      Text(
                                        _translate('form_password'),
                                        style: TextStyle(fontSize: 17.0)),
                                      SizedBox(height: 5.0,),
                                      _passwordField(bloc),
                                      SizedBox(height: 10.0),
                                      _forgotPassword(),
                                      SizedBox(height: 20.0),
                                      _loginButton(bloc, screenSize),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                  ),
              ),
            ),
            _isLoading
            ? Positioned.fill(
                child: Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
            : Container()
          ],
        ),
      )
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  Widget _emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          focusNode: _focusNode,
          bloc: bloc,
          snapshot: snapshot,
          textType: TextInputType.emailAddress,
          onChange: bloc.changeEmail,
        );
      },
    );
  }

  Widget _passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          hintText: '',
          bloc: bloc,
          snapshot: snapshot,
          obscureText: true,
          onChange: bloc.changePassword,
        );
      },
    );
  }

  Widget _loginButton(LoginBloc bloc, screenSize) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: 
          screenSize.width < 350
            ? EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0)
            : EdgeInsets.only(left: 50.0, right: 50.0, bottom: 40.0),
          child: AppButton(
            color:  Colors.black38,
            name: _translate('login_title'),
            textStyle: TextStyle(fontSize: 17, color: Colors.white),
            onPressed: () => _loginPress(context, bloc, snapshot)
          )
        );
      },
    );
  }

  _loginPress(BuildContext context, LoginBloc bloc, AsyncSnapshot snapshot) async{
    if (snapshot.hasData){
      setState(() {
        _isLoading = true;
      });
      Map info = await usersProvider.login(bloc.email, bloc.password);
      if(info['ok']){
        _getUser(info);
      }else{
        setState(() {
          _isLoading = false;
        });
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate(info['message']))
        );
      }
    }else{
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate('form_complete_error'))
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  _getUser(info) async{
    Map setupInfo = await usersProvider.getSetup();
    if(setupInfo['ok']){
      _prefs.studies = setupInfo['info']['numberStudies'];
      if(setupInfo['info']['country'] != null && setupInfo['info']['gender'] != null && setupInfo['info']['birthdate'] != null && setupInfo['info']['diseases'] != null && setupInfo['info']['weight'] != null && setupInfo['info']['height'] != null){
        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> r) => false);
        // if(setupInfo['info']['numberStudies'] != 0){
        //   Navigator.pushNamedAndRemoveUntil(_scaffoldKey.currentState.context, '/communitystudy', (Route<dynamic> r) => false);
        // }else{
        //   Navigator.pushNamedAndRemoveUntil(_scaffoldKey.currentState.context, '/addstudy', (Route<dynamic> r) => false);
        // }
      }else{
        Navigator.pushNamedAndRemoveUntil(_scaffoldKey.currentState.context, '/setup', (Route<dynamic> r) => false);
      }
    }else{
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate('not_working_body'))
      );
      setState(() {
        _isLoading = false;
      });
    }
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

  Widget _forgotPassword(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: _translate('form_forgot_password'),
              style: new TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/forgotpassword');
                }
              )
            ]
          ),
        )
      ],
    );
  }

  Widget _registerButton(){
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _translate('signup_title'),
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat'
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = (){
                Navigator.pushNamed(context, '/signup');
              }
          )
        ]
      )
    );
  }
}
