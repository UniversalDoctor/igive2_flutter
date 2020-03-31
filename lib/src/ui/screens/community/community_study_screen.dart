import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_event_bus/flutter_event_bus.dart';
import 'package:flutter_event_bus/flutter_event_bus/EventBus.dart';
import 'package:flutter_event_bus/flutter_event_bus/Interactor.dart';
import 'package:fit_kit/fit_kit.dart';
import 'dart:convert';


import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/providers/study_provider.dart';
import 'package:igive2/src/providers/health_data_provider.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/ui/screens/community/study_detail_screen.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/translations.dart';
import 'package:intl/intl.dart';

class CommunityStudyScreen extends StatefulWidget {
  static const String routeName = '/communitystudy';

  @override
  _CommunityStudyScreenState createState() => new _CommunityStudyScreenState();
}

class _CommunityStudyScreenState extends Interactor<CommunityStudyScreen> {

  //---fitkit---
  String result = '';
  int _steps = 0;
  double _heartRate = 0;
  double _distance = 0;
  int _sleep = 0;
  double _energy = 0;
  Map<DataType, List<FitData>> results = Map();
  bool permissions;
  //---fitkit---

  bool _noStudies = true;
  bool _isLoading = true;
  bool _isLoadingState = false;
  String userId;
  List studies = [];
  List details = [];
  List dynamicIcons = [];
  int selectedStudy = 0;
  FocusNode _focusNode;
  final bloc = Provider.hypertensionBloc();
  final _healthDataProvider = HealthDataProvider();
  final _usersProvider = UsersProvider();
  final _studyProvider = StudyProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    this.getStudies();
    _focusNode = FocusNode();
    bloc.resetControllers();
    super.initState();
  }

  @override
  void dispose(){
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> readFitKitData() async{
    results.clear();
    _steps = 0;
    _distance = 0;
    _heartRate = 0;
    _sleep = 0;
    _energy = 0;


    try{
      permissions = await FitKit.requestPermissions([DataType.STEP_COUNT, DataType.DISTANCE, DataType.ENERGY, DataType.SLEEP, DataType.HEART_RATE]);
      if(!permissions){
        _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate('permissions_snackbar_not_accepted'))
      );
      }else{
        for(DataType type in [DataType.STEP_COUNT, DataType.DISTANCE, DataType.ENERGY, DataType.SLEEP, DataType.HEART_RATE]){
          results[type] = await FitKit.read(
            type,
            dateFrom: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-1),
            dateTo: null,
            limit: null,
          );
        }
        
        if(results[DataType.DISTANCE].length != 0){
          for(var i = 0; i < results[DataType.DISTANCE].length; i++){
            if(results[DataType.DISTANCE][i].dateFrom.day == DateTime.now().day){
              _distance = _distance + results[DataType.DISTANCE][i].value;
            }
          }
        }

        if(results[DataType.STEP_COUNT].length != 0){
          for(var i = 0; i < results[DataType.STEP_COUNT].length; i++){
            if(results[DataType.STEP_COUNT][i].dateFrom.day == DateTime.now().day){
              _steps = _steps + results[DataType.STEP_COUNT][i].value;
            }
          }
          await _healthDataProvider.sendHealthData('STEPS', _steps.toString());
        }

        if(results[DataType.ENERGY].length != 0){
          for(var i = 0; i < results[DataType.ENERGY].length; i++){
            if(results[DataType.ENERGY][i].dateFrom.day == DateTime.now().day){
              _energy = _energy + results[DataType.ENERGY][i].value;
            }
          }
        }

        if(results[DataType.SLEEP].length != 0){
          for(var i = 0; i < results[DataType.SLEEP].length; i++){
            _sleep = _sleep + results[DataType.SLEEP][i].dateTo.difference(results[DataType.SLEEP][i].dateFrom).inMinutes;
          }
          await _healthDataProvider.sendHealthData('SLEEP', _sleep.toString());
        }

        if(results[DataType.HEART_RATE].length != 0){
          _heartRate = results[DataType.HEART_RATE][0].value;
          await _healthDataProvider.sendHealthData('HEARTHRATE', _heartRate.toString());
        }

      }
     }catch(e){
      result = 'readAll: $e';
    }
  }

  Future<void> hasPermissions() async{
    permissions = await FitKit.hasPermissions([DataType.STEP_COUNT, DataType.DISTANCE, DataType.ENERGY, DataType.SLEEP, DataType.HEART_RATE]);
    if(!permissions){
      _showAlertPermissions();
    }else{
      this.readFitKitData();
    }
  }

  _showAlertPermissions(){
    TextStyle style = TextStyle(fontSize: 15.0, fontFamily: 'MontserratLight');
    TextAlign justif = TextAlign.justify;

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xfffaf8f6),
          title: Text(_translate('alert_permissions_title'), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  _translate('alert_permissions_description'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 40),
                Text(
                  _translate('alert_permissions_text_1'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 10),
                Text(
                  _translate('alert_permissions_text_2'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 10),
                Text(
                  _translate('alert_permissions_text_3'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 10),
                Text(
                  _translate('alert_permissions_text_4'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 10),
                Text(
                  _translate('alert_permissions_text_5'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 40),
                Text(
                  _translate('alert_permissions_semifinal'),
                  style: style, textAlign: justif,
                ),
                SizedBox(height: 20,),
                Text(
                  _translate('alert_permissions_final'),
                  style: style, textAlign: justif,
                )
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              color: Colors.blueAccent[100],
              name: _translate('alert_permissions_ok_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: () {
                Navigator.of(context).pop();
                this.readFitKitData();
              },
            )
          ],
        );
      }
    );
  }

  void getStudies() async{
    hasPermissions();
    Map userIdInfo = await _usersProvider.getProfile();
    if(userIdInfo['ok']){
      Map studiesInfo = await _studyProvider.getStudies();
      if(studiesInfo['ok']){
        if(studiesInfo['info'].length == 0){
          if(this.mounted){
            setState(() {
              _isLoading = false;
              _noStudies = true;
              _isLoadingState = false;
            });
          }
        }else{
          List studyDetails = [];
          for(var i = 0; i < studiesInfo['info'].length; i++){
            Map studyDetailsInfo = await _studyProvider.getStudyDetails(studiesInfo['info'][i]['idStudy']);
              if(studyDetailsInfo['ok']){
                studyDetails.add(studyDetailsInfo['info']);
              }else {
                if(this.mounted){
                  setState(() {
                    _isLoading = false;
                    _isLoadingState = false;
                  });
                }
                _scaffoldKey.currentState.showSnackBar(
                  _showSnackBar(_translate(studyDetailsInfo['message']))
                );
              }
          }
          if(this.mounted){
            setState(() {
              _noStudies = false;
              details = studyDetails;
              studies = studiesInfo['info'];
              userId = userIdInfo['info']['userId'];
            });
          }
        }
      }else{
        if(this.mounted){
          setState(() {
            _isLoading = false;
            _isLoadingState = false;
          });
        }
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate(studiesInfo['message']))
        );
      }

    }else{
      if(this.mounted){
        setState(() {
          _isLoading = false;
          _isLoadingState = false;
        });
      }
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate(userIdInfo['message']))
      );
    }
      _addDynamic();
  }

  void getStudiesEvent(StudyDetailScreen event){
      _showLeaveDialog();
    // leaveGroup();
  }

  void leaveGroup() async{
    Navigator.of(context).pop();
    setState(() {
      _isLoading = true;
    });

    Map leaveInfo = await _studyProvider.leaveStudy(studies[selectedStudy]['idParticipant']);
    if(leaveInfo['ok']){
      Map profileInfo = await _usersProvider.getProfile();
      if(profileInfo['ok']){

        setState(() {
          selectedStudy = 0;
          studies = profileInfo['info']['studies'];
        });
        if(studies.length == 0){
          Navigator.pushNamedAndRemoveUntil(context, '/addstudy', (Route<dynamic> r) => false);
        }
        getStudies();
      }else{
        if(this.mounted){
          setState(() {
            _isLoading = false;
          });
        }
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate(profileInfo['message']))
        );
      }
    }else{
      if(this.mounted){
        setState(() {
          _isLoading = false;
        });
      }
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate(leaveInfo['message']))
      );
    }
  }

  _addDynamic(){
    dynamicIcons = [];
    dynamicIcons.add(AddButtonWidget());
    for(var i = 0; i < studies.length; i++){
      dynamicIcons.add(_dynamicIconsWidget(i));
      if(i == studies.length - 1){
        if(this.mounted){
          setState(() {
            _isLoading = false;
            _isLoadingState = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: _floatingButtons(bloc),
      body: Stack(
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
            : 
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _topNavigation(),
                  _noStudies == true && _isLoadingState == false
                    ? Container(
                        height: MediaQuery.of(context).copyWith().size.height / 2,
                        child: Center(
                          child: Text('You are not in a study'),
                        )
                    )
                    : StudyDetailScreen(study: studies[selectedStudy], details: details, selected: selectedStudy),
                ],
              ),
            )
          ),
          _isLoadingState
            ? Positioned.fill(
                child: Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
            : 
            Container()
        ],
      ),
    );
  }

  @override
  Subscription subscribeEvents(EventBus eventBus) => eventBus.respond<StudyDetailScreen>(getStudiesEvent);

  _dynamicIconsWidget(i){
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      width: 60.0,
      child: Material(
        color: Colors.transparent,
        child: FlatButton(
          shape: CircleBorder(),
          highlightColor:  Colors.transparent,
          splashColor: Colors.transparent,

          onPressed: () {
            if(this.mounted){
              setState(() {
                selectedStudy = i;
              });
            }
            _addDynamic();
          },
          padding: EdgeInsets.all(0.0),
          child:
          studies[i]['iconStudy'] != '' && studies[i]['iconStudy'] != null ?
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  selectedStudy == i ?
                  "assets/img/3.0x/blancoon.png":
                  "assets/img/3.0x/blanco.png",
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.memory(
                  base64Decode(studies[i]['iconStudy']),
                  height: 33.0,
                  gaplessPlayback: true,
                  fit: BoxFit.cover,
                )
              )
            ],
          )
          :
          Image.asset(
              selectedStudy == i ?
              "assets/img/3.0x/blancoon.png":
              "assets/img/3.0x/blanco.png",
            height: 60.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _topNavigation(){
    return Container(
      color: Color(0xffF0EDEB),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 80.0,
          child: Row(
            children: <Widget>[
              SizedBox(width: 10.0,),
              
              dynamicIcons.length == 0 ?
                SizedBox() 
                :
              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dynamicIcons.length,
                  itemBuilder: (_,index) => dynamicIcons[index],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  _floatingButtons(bloc){
    if(!_isLoading && !_isLoadingState){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'btn1',
            elevation: 0,
            backgroundColor: Colors.black45,
            child: Icon(
              Icons.assignment,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => _isLoadingState ? null : _showStepsDialog()
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'btn2',
            elevation: 0,
            backgroundColor: Colors.black45,
            child: Image(
              image: AssetImage('assets/icons/heart-pulse.png'),
              color: Colors.white,
              fit: BoxFit.contain,
              height: 35.0,
            ),
            onPressed: () => _isLoadingState ? null : _addHypertensionValue(bloc)
          ),
          SizedBox(width: 10.0),
          // FloatingActionButton(
          //   heroTag: 'btn3',
          //   elevation: 0,
          //   backgroundColor: Colors.black45,
          //   child: Image(
          //     image: AssetImage('assets/img/Settings.png'),
          //     fit: BoxFit.cover,
          //     height: 30,
          //     color: Colors.white,
          //   ),
          //   onPressed: () => _isLoadingState ? null : Navigator.pushNamed(context, '/settings')
          // ),
        ],
      );
    }
  }

  _addHypertensionValue(AddHypertensionValueBloc bloc){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xfffaf8f6),
          title: Text(_translate('hypertension_add_value'), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    child: _hypertensionHighInput(bloc)
                  ),
                  Container(
                    height: 40.0,
                    child: Text('/', style: TextStyle(fontSize: 30, fontFamily: 'MontserratLight'),),
                  ),
                  Container(
                    width: 80.0,
                    child: _hypertensionLowInput(bloc)
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  
                ],
              ),
            ],
          ),
          actions: <Widget>[
            _saveButton(bloc),
            AppButton(
              color: Color(0xffff9292),
              name: _translate('cancel_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: (){
                bloc.resetControllers();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget _saveButton(AddHypertensionValueBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppButton(
          color: Colors.blueAccent[100],
          name: _translate('save_button'),
          textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _saveHypertension(context, bloc, snapshot);
          },
        );
      },
    );
  }

  _saveHypertension(BuildContext context, AddHypertensionValueBloc bloc, AsyncSnapshot snapshot) async{
    if( snapshot.hasData){
      Navigator.of(context).pop();
      if(this.mounted){
        setState(() {
          _isLoadingState = true;
        });
      }
      if(double.parse(bloc.highPressure) < 20 || double.parse(bloc.lowPressure) < 20){
        _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate('hypertension_incorrect_value'))
        );
        Future.delayed(Duration(seconds: 2), () { _scaffoldKey.currentState.hideCurrentSnackBar(); });
      } else {
        if(this.mounted){
          setState(() {
            _isLoading = false;
          });
        }
        Map addHypertensionInfo = await _usersProvider.postHypertension(bloc.highPressure, bloc.lowPressure);
        if(addHypertensionInfo['ok']){
          if(this.mounted){
            setState(() {
              _isLoadingState = false;
            });
          }
          _scaffoldKey.currentState.showSnackBar(
            _showSuccessSnackBar(_translate('save_data_success'))
          );
          bloc.resetControllers();
        }else{
          if(this.mounted){
            setState(() {
              _isLoadingState = false;
            });
          }
          _scaffoldKey.currentState.showSnackBar(
            _showSnackBar(_translate('not_working_body'))
          );
          Future.delayed(Duration(seconds: 2), () { _scaffoldKey.currentState.hideCurrentSnackBar(); });
        }
      }
    }else{
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate('hypertension_empty_fields'))
      );
      Future.delayed(Duration(seconds: 2), () { _scaffoldKey.currentState.hideCurrentSnackBar(); });
    }
  }


  _showStepsDialog(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xfffaf8f6),
          title: Text('Your health data', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_translate('health_data_steps')}: ', style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat')),
                  Text('$_steps', style:TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.red[200]))
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_translate('health_data_distance')}: ', style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat')),
                  Text('${(_distance / 1000).toStringAsFixed(2)} km', style:TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.red[200]))
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_translate('health_data_calories')}: ', style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat')),
                  Text('${(_energy).toStringAsFixed(0)} cal', style:TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.red[200]))
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_translate('health_data_heart')}: ', style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat')),
                  Text('$_heartRate', style:TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.red[200]))
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_translate('health_data_sleep')}: ', style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat')),
                  Text('${(_sleep / 60).toStringAsFixed(2)} h', style:TextStyle(fontSize: 17.0, fontFamily: 'Montserrat', color: Colors.red[200]))
                ],
              ),
            ],
          ),
          actions: <Widget>[
            AppButton(
              color: Colors.blueAccent[100],
              name: _translate('close_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
  
  
  Widget _hypertensionLowInput(AddHypertensionValueBloc bloc){
    return StreamBuilder(
      stream: bloc.lowPressureStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          hyper: true,
          hintText: 'DIA. mmHg',
          black: true,
          snapshot: snapshot,
          bloc: bloc,
          onChange: bloc.changeLowPressure,
          textType: TextInputType.number,
        );
      },
    );
  }

  Widget _hypertensionHighInput(AddHypertensionValueBloc bloc){
    return StreamBuilder(
      stream: bloc.highPressureStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          hyper: true,
          hintText: 'SYS. mmHg',
          black: true,
          snapshot: snapshot,
          bloc: bloc,
          onChange: bloc.changeHighPressure,
          textType: TextInputType.number,
        );
      },
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

  Widget _showSuccessSnackBar(translation){
      return SnackBar(
        duration: Duration(seconds: 2),
        content: Container(
          height: 40.0,
          child: Center(child: Text(translation, style: TextStyle(color: Color(0xff8AF9FF)))),
        ),
    );
  }

  _showLeaveDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xfffaf8f6),
          title: Text(_translate('leave_group_title'), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18)),
          content: Text(_translate('leave_group_body'), textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
          actions: <Widget>[
            AppButton(
              color: Colors.blueAccent[100],
              name: _translate('leave_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: leaveGroup,
            ),
            AppButton(
              color: Color(0xffff9292),
              name: _translate('cancel_button'),
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
}


class AddButtonWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      child: Material(
        color: Colors.transparent,
        child: FlatButton(
          shape: CircleBorder(),
          highlightColor:  Colors.transparent,
          splashColor: Colors.transparent,

          onPressed: () => Navigator.pushNamed(context, '/addstudy'),
          padding: EdgeInsets.all(0.0),
          child: Image.asset(
            "assets/img/3.0x/studioc.png",
            height: 60.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}