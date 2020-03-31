import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/bloc/signup_bloc.dart';
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/ui/widgets/terms_conditions.dart';
import 'package:igive2/src/translations.dart';

class SignUpScreen extends StatefulWidget {

  static const String routeName = '/signup';
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode _focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool termsConditions = true;
  bool acceptTerms = false;
  bool showErrorSignup = false;
  bool _isLoading = false;
  bool _registerPressed = false;
  final usersProvider = new UsersProvider();
  final bloc = Provider.signupBloc();

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

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal: screenSize.width < 350 ? 40.0 : 60.0),
                  child: SafeArea(
                    child: Form(
                      key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 60.0),
                            Container(
                              child: Center(
                                child: Text(_translate('signup_title'),style: TextStyle(fontSize: 30, letterSpacing: 5.0,fontFamily: 'MontserratBold'),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(_translate('form_name'),style: TextStyle(fontSize: 17.0)),
                                  SizedBox(height: 5.0),
                                  _nameField(bloc),
                                  Text(_translate('form_lastname'),style: TextStyle(fontSize: 17.0)),
                                  SizedBox(height: 5.0),
                                  _lastNameField(bloc),
                                  Text(_translate('form_email'),style: TextStyle(fontSize: 17.0)),
                                  SizedBox(height: 5.0),
                                  _emailField(bloc),
                                ],
                              )
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(height: 40.0),
                                  Text(_translate('form_password'),style: TextStyle(fontSize: 17.0)),
                                  SizedBox(height: 5.0),
                                  _passwordField(bloc),
                                  Text(_translate('form_repeat_password'),style: TextStyle(fontSize: 17.0)),
                                  SizedBox(height: 5.0),
                                  _repeatPasswordField(bloc),
                                  SizedBox(height: 30.0),
                                  _acceptNewsletter(bloc),
                                  // _acceptTermsConditions(bloc),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _signupButton(bloc, screenSize)
                              ],
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              ),
            ),
            AppBackButton(),

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
        )
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  void _showAlert(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            _translate('terms_conditions_title'),
            style: TextStyle(
              fontFamily: 'MontserratSemiBold'
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(child: TermsConditions()),
          actions: <Widget>[
            AppButton(
              color: Colors.blueAccent[100],
              name: _translate('accept_button'),
              textStyle: TextStyle(
                color: Colors.black
              ),
              onPressed: () {
                if(_registerPressed == true){
                  _auth();
                }else{
                  setState(() {
                    termsConditions = true;
                  });
                  Navigator.of(context).pop();
                }
              } 
            ),
            AppButton(
              color: Color(0xffff9292),
              name: _translate('cancel_button'),
              textStyle: TextStyle(
                color: Colors.black
              ),
              onPressed: (){
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              } 
            )
          ],
        );
      }
    );
  }

  _termsConditionsButton(){
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _translate('signup_accept_terms_conditions') + ' ',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat'
            ),
          ),
          TextSpan(
            text: _translate('terms_conditions'),
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.underline
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = (){
                _showAlert();
              }
          ),
          TextSpan(
            text: ' ' + _translate('signup_accept_terms_conditions_2'),
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat'
            ),
          )
        ]
      )
    );
  }

  Widget _nameField(SignupBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          focusNode: _focusNode,
          bloc: bloc,
          capitalization: TextCapitalization.words,
          snapshot: snapshot,
          onChange: bloc.changeName,
        );
      },
    );
  }

  Widget _lastNameField(SignupBloc bloc) {
    return StreamBuilder(
      stream: bloc.lastNameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          bloc: bloc,
          capitalization: TextCapitalization.words,
          snapshot: snapshot,
          onChange: bloc.changeLastName,
        );
      },
    );
  }

  Widget _emailField(SignupBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          textType: TextInputType.emailAddress,
          bloc: bloc,
          snapshot: snapshot,
          onChange: bloc.changeEmail,
        );
      },
    );
  }

  Widget _passwordField(SignupBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          obscureText: true,
          bloc: bloc,
          snapshot: snapshot,
          onChange: bloc.changePassword,
        );
      },
    );
  }

  Widget _repeatPasswordField(SignupBloc bloc) {
    return StreamBuilder(
      stream: bloc.repPasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          obscureText: true,
          bloc: bloc,
          snapshot: snapshot,
          onChange: bloc.changeRepPassword,
        );
      },
    );
  }

  Widget _signupButton(SignupBloc bloc, screenSize){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: screenSize.width < 350
            ? EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0)
            : EdgeInsets.only(left: 50.0, right: 50.0, bottom: 40.0),
          child: AppButton(
            color: Colors.black38,
            textStyle: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Montserrat'),
            name: _translate('form_signup_button'),
            onPressed: termsConditions ? () {
              _registerPressed = true;
              _signupPress(context, bloc, snapshot);
            } 
            :
            null
          ),
        );
      },
    );
  }
  _signupPress(BuildContext context, SignupBloc bloc, AsyncSnapshot snapshot) async{
    if(bloc.repPassword != bloc.password){
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate('form_passwords_error'))
      );
    }else if(snapshot.hasData){
      setState(() {
        _isLoading = true;
        showErrorSignup = false;
      });
      var auth = true;
      if(auth){
        _showAlert();
      }
    }else{
      setState(() {
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate('form_complete_error'))
        );
      });
    }
  }
  _auth() async{
    final _prefs = UserPreferences();
    await _prefs.initPrefs();
    Map info = await usersProvider.signup(bloc.email, bloc.name, bloc.lastName, bloc.password, _prefs.systemLang, bloc.newsletter);
    if(info['ok']){
      if(info['statusCode'] == 201 || info['statusCode'] == 200){
        Navigator.popAndPushNamed(_scaffoldKey.currentState.context, '/confirmmail');
      }else{
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate('not_working_body'))
        );
      }
    }else{
      setState(() {
        _isLoading = false;
      });
      if(info['errorKey'] == 'userexists'){
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate('email_in_use'))
        );
      }else{
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate('not_working_body'))
        );
      }
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

  Widget _acceptNewsletter(SignupBloc bloc){
    return StreamBuilder(
      stream: bloc.newsletterStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Row(
          children: <Widget>[
            Checkbox(
              value: bloc.newsletter,
              checkColor: Colors.white,
              activeColor: Colors.black38,
              onChanged: bloc.changeNewsletter,
            ),
            Flexible(
              child: Text(
                _translate('signup_accept_newsletter'),
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _acceptTermsConditions(SignupBloc bloc){
    return Row(
      children: <Widget>[
        Checkbox(
          value: termsConditions,
          checkColor: Colors.white,
          activeColor: Colors.black38,
          onChanged: (bool value) {
            setState(() {
              termsConditions = value;
            });
          },
        ),
        Flexible(
          child: _termsConditionsButton(),
        )
      ],
    );
  }
}