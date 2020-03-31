import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/app_icon.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';
import 'package:igive2/src/translations.dart';
import 'package:igive2/src/providers/users_provider.dart';


class ForgotPasswordScreen extends StatefulWidget {

  static const String routeName = '/forgotpassword';
  @override
  _ForgotPasswordScreenState createState() => new _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  FocusNode _focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showErrorForgotPass = false;
  final usersProvider = UsersProvider();
  bool _isLoading = false;
  final bloc = Provider.forgotPassBloc();

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
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            _isLoading
            ? Positioned.fill(
                child: Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
            : Container(),
            SingleChildScrollView(
              child: Container(
                height: screenSize.height,
                margin: EdgeInsets.symmetric(horizontal: 60.0),
                  child: SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppIcon(size: 200.0),
                          SizedBox(height: 60.0,),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _infoTextContent(),
                                SizedBox(height: 20.0),
                                Text(_translate('form_email'),
                                  style: TextStyle(fontSize: 17.0)
                                ),
                                SizedBox(height: 5.0),
                                _emailField(bloc),
                                SizedBox(height: 40.0),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      showErrorForgotPass ? _showError() : Text('',style: TextStyle(fontSize: 12.0),),
                                      _submitButton(bloc),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ),
            ),
            AppBackButton(),
          ],
        )
      )
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  Widget _showError(){
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        _translate('form_complete_error'),
        style: TextStyle(
          color: Color(0xffff9292),
          fontSize: 12.0,
        ),
      )
    );
  }

  Widget _infoTextContent() {
    return Container(
      child: Text(
        _translate('restore_password_indications'),
        textAlign: TextAlign.justify
      ),
    );
  }

  Widget _emailField(ForgotPassBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          height: 60.0,
          child: AppTextField(
            focusNode: _focusNode,
            bloc: bloc,
            snapshot: snapshot,
            textType: TextInputType.emailAddress,
            onChange: bloc.changeEmail,
          ),
        );
      },
    );
  }
  
  Widget _submitButton(ForgotPassBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: AppButton(
            color: Colors.black38,
            name: _translate('form_send_button'),
            textStyle: TextStyle(fontSize: 17, color: Colors.white),
            onPressed: () async {
              if(snapshot.hasData){
                //to avoid overflow error --> keyboard on 
                // FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  _isLoading = true;
                });
                Map info = await usersProvider.resetPassword(bloc.email);
                if(info['ok']){
                  Navigator.popAndPushNamed(_scaffoldKey.currentState.context, '/forgotpassword2');
                }else{
                  setState(() {
                    _isLoading = false;
                  });
                  if(info['message'] == 'wrong_email'){
                    _scaffoldKey.currentState.showSnackBar(
                      _showSnackBar(_translate('restore_password_alert_body'))
                    );
                  }else{
                    _scaffoldKey.currentState.showSnackBar(
                      _showSnackBar(_translate('not_working_body'))
                    );
                  }
                }
              }else{
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(
                    _showSnackBar(_translate('form_complete_error'))
                  );
                });
              }
            }
          ),
        );
      },
    );
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