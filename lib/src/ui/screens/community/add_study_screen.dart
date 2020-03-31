import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/preferences/user_preferences.dart';
import 'package:igive2/src/providers/study_provider.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_icon.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';
import 'package:igive2/src/translations.dart';


class AddStudyScreen extends StatefulWidget {

  static const String routeName = '/addstudy';
  @override
  _AddStudyScreenState createState() => new _AddStudyScreenState();
 }

class _AddStudyScreenState extends State<AddStudyScreen> {

  FocusNode _focusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _usersProvider = UsersProvider();
  final _studyProvider = StudyProvider();
  bool isLoading = false;
  final bloc = Provider.addStudyBloc();
  final _prefs = new UserPreferences();

  @override
  void initState(){
    super.initState();

    _focusNode = FocusNode();
    bloc.resetControllers();
    this.checkToken();
  }

  @override
  void dispose(){
    super.dispose();
    _focusNode.dispose();
  }

  checkToken() async{
    final token = await _usersProvider.getAccessToken();
    if(token == null){
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _prefs.initPrefs();
    

    return new Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppIcon(size: 200.0),
                        SizedBox(height: 30.0),
                        Container(
                          child: Text(
                            _translate('form_code_field'),
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        _codeField(bloc),
                        SizedBox(height: 20.0),
                        _accessButton(bloc),
                      ],
                    ),
                  ),
                ),
            ),
            AppBackButton(),
            isLoading
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

  Widget _codeField(AddStudyBloc bloc){
    return StreamBuilder(
      stream: bloc.codeStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          focusNode: _focusNode,
          snapshot: snapshot,
          bloc: bloc,
          onChange: bloc.changeCode,
        );
      },
    );
  }

  Widget _accessButton(AddStudyBloc bloc){
    return StreamBuilder(
      stream: bloc.codeStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: AppButton(
            color: Colors.black38,
            name: _translate('code_home_button'),
            textStyle: TextStyle(fontSize: 17, color: Colors.white),
            onPressed: () {
              if(snapshot.hasData){
                _getStudyData();
              }else{
                _scaffoldKey.currentState.showSnackBar(
                  _showSnackBar(_translate('form_complete_error'))
                );
              }
            }
          ),
        );
      },
    );
  }

  _getStudyData() async{
    setState(() {
      isLoading = true;
    });
    Map studyInfo = await _studyProvider.getStudyInfo(bloc.code);
    if(studyInfo['ok']){
      setState(() {
        isLoading = false;
      });
      _showAddStudyDialog(studyInfo['message']);
    }else{
        setState(() {
          isLoading = false;
        });
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate(studyInfo['message']))
      );
    }

  }

  _showAddStudyDialog(studyInfo){
    List studyInformation = [];
    studyInformation = studyInfo['requestedData'].split(",");

    String info = '';

    for(var i  = 0; i < studyInformation.length; i++){
      if( i == 0){
        info = _translate(studyInformation[i]);
      }else{
        info = info + ', ' + _translate(studyInformation[i]);
      }
    }

    TextStyle style = TextStyle(fontSize: 15.0, fontFamily: 'Montserrat');
    TextAlign align = TextAlign.justify;
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xfffaf8f6),
          title: Text(_translate('add_study_title'), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _translate('add_study_text_1') + _translate('add_study_text_2') + ' ${studyInfo['name'].toString()}.',
                  style: style, textAlign: align,
                ),
                Text(
                  _translate('add_study_text_3'),
                  style: style, textAlign: align,
                ),
                SizedBox(height: 5.0,),
                Text(
                  info,
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', color: Colors.blueAccent[200]), textAlign: align
                ),
                SizedBox(height: 15.0,),
                studyInfo['dataJustification'] == null
                  ? SizedBox()
                  : Text(studyInfo['dataJustification'], style: TextStyle(fontFamily: 'MontserratLight', fontSize: 13), textAlign: align,),
                SizedBox(height: 15.0,),
                Text(
                  _translate('add_study_text_4'),
                  style: style, textAlign: align,
                ),
                SizedBox(height: 15.0,),
                Text(
                  _translate('add_study_text_5'),
                  style: style, textAlign: align,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StreamBuilder(
              stream: bloc.codeStream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                return AppButton(
                  color: Colors.blueAccent[100],
                  name: _translate('yes_button'),
                  textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _acceptTerms(snapshot);
                  },
                );
              },
            ),
            AppButton(
              color: Color(0xffff9292),
              name: _translate('no_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  _acceptTerms(AsyncSnapshot snapshot) async{
      setState(() {
        isLoading = true;
      });

      Map addStudyInfo = await _studyProvider.addStudy(bloc.code);

      if(addStudyInfo['ok']){
        Navigator.pushNamedAndRemoveUntil(_scaffoldKey.currentState.context, '/home', (Route<dynamic> r) => false);
      }else{
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate(addStudyInfo['message']))
        );
      }
      //Todo:: Validate if code is correct
      setState(() {
        isLoading = false;
      });
    
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