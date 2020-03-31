import 'package:flutter/material.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_icon.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/translations.dart';

class ForgotPassword2Screen extends StatefulWidget {
  
  final String forgotEmail;
  const ForgotPassword2Screen({this.forgotEmail});

  static const String routeName = '/forgotpassword2';

  @override
  _ForgotPassword2ScreenState createState() => _ForgotPassword2ScreenState();
}

class _ForgotPassword2ScreenState extends State<ForgotPassword2Screen> {
  final bloc = Provider.forgotPassBloc();

  @override
  void initState() {
    super.initState();
    // bloc.resetControllers();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          SingleChildScrollView(
            child: Container(
              height: screenSize.height,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _topLogo(),
                    SizedBox(height: 100),
                    _emailInformation(bloc),
                    SizedBox(height: 20.0,),
                    _indications(),
                    SizedBox(height: 50.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 110.0),
                      child: _sendButton()
                    )
                  ],
                ),
              ),
            ),
          ),
          AppBackButton(),
        ],
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  Widget _topLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 20.0, top: 20.0),
          child: AppIcon(size: 100),
        ),
      ],
    );
  }

  Widget _emailInformation(ForgotPassBloc bloc){
    return Container(
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage('assets/img/3.0x/email.png'),
            height: 100.0,
          ),
          SizedBox(height: 20.0),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  _translate('restore_password_email'),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  bloc.email,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }


  Widget _indications(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _indicationsText(),
        ],
      ),
    );
  }

  Widget _indicationsText(){
    return Column(
      children: <Widget>[
        Text(
          _translate('restore_password_secure_link'),
          style: TextStyle(
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 60.0),
        Text(
          _translate('restore_password_spam'),
          style: TextStyle(
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _sendButton(){
    return AppButton(
      color: Colors.black38,
      name: _translate('restore_password_send_button'),
      textStyle: TextStyle(fontSize: 17, color: Colors.white),
      onPressed: () async {
      },
    );
  }
}