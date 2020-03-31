import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:igive2/src/translations.dart';

//open mail app
// import 'dart:io';
// import 'package:flutter_appavailability/flutter_appavailability.dart';


class ConfirmMailScreen extends StatefulWidget {

  static const String routeName = '/confirmmail';
  @override
  _ConfirmMailScreenState createState() => new _ConfirmMailScreenState();
}

class _ConfirmMailScreenState extends State<ConfirmMailScreen> {
  final _bloc = SignupBloc();

  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.signupBloc();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            Container(
              child: SingleChildScrollView(
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 60.0),
                  child: SafeArea(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppIcon(size: 200.0),
                          SizedBox(height: 30.0),
                          _nameEmailInformation(bloc),
                          SizedBox(height: 50.0),
                          Text(
                            _translate('confirm_email_spam'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.0),
                          _mailButton(_bloc),
                          SizedBox(height: 10.0),
                          _resendText(),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }
  _nameEmailInformation(SignupBloc bloc){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            _translate('confirm_email_welcome')+', ${bloc.name}!', 
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            _translate('confirm_email_instructions'),
            style: TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            bloc.email, 
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _resendText(){
    return Column(
      children: <Widget>[
        Text(
          _translate('confirm_email_no_email'),
        ),
        SizedBox(height: 10.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _translate('confirm_email_resend'),
                style: TextStyle(decoration: TextDecoration.underline),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {}
              )
            ]
          ),
        ),
      ],
    );
  }

  Widget _mailButton(_bloc){
    return AppButton(
      color: Colors.black38,
      name: _translate('login_title'), 
      textStyle: TextStyle(fontSize: 17, color: Colors.white),
      onPressed: () async {
        Navigator.pushNamed(context, '/login');
      }
    );
  }
}