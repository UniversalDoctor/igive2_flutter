import 'dart:async';

import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:igive2/src/translations.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/utils/countries.dart';
import 'package:igive2/src/utils/medical_conditions.dart';
import 'package:intl/intl.dart';


class SetUpScreen extends StatefulWidget {
  
  static const String routName = '/setup';
  
  @override
  _SetUpScreenState createState() => new _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  
  final bloc = Provider.setupBloc();
  FocusNode _focusNode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  final _usersProvider = UsersProvider();
  bool _isLoading = true;
  String _selectedGender = 'FEMALE';
  var _medicalCondition = medicalConditions;
  String _medicalConditionSelected = medicalConditions[0];
  var _countries = countries;
  String _countriesSelected = countries[0];
  DateTime _birthDate = DateTime.now();
  String _height = '';
  String _weight = '';
  Map userInformation = {};
  bool _noInfo = true;
  



  @override
  void initState() {
    bloc.resetControllers();
    _focusNode = FocusNode();
    this._getData();
    super.initState();
  }

  Future _getData() async{
    Map setupInfo = await _usersProvider.getSetup();
    if(setupInfo['ok']){
      if(setupInfo['info']['weight'] == null || setupInfo['info']['height'] == null){
        setState(() {
          userInformation = setupInfo['info'];
        });
      }else{
        setState(() {
          _noInfo = false;
          userInformation = setupInfo['info'];
        });
      }
      _setUserInfo(setupInfo['info']);
    }else{
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
    }

  }

  _setUserInfo(info){
    DateTime birthDate = DateTime.now();
    String condition = medicalConditions[0];
    String country = countries[0];
    String gender = 'FEMALE';
    String height = '0';
    String weight = '0';

    if(info['birthdate'] != null){
      birthDate = DateTime.parse(info['birthdate']);
    }
    if(info['country'] != null){
      if(info['country'] == 'ES'){
        country = 'Spain';
      }else{
        country = info['country'];
      }
    }
    if(info['diseases'] != null){
      condition = info['diseases'];
    }
    if(info['gender'] != null){
      gender = info['gender'];
    }
    if(info['weight'] != null){
      weight = info['weight'];
    }
    if(info['height'] != null){
      height = info['height'];
    }

    setState(() {
      _birthDate = birthDate;
      _medicalConditionSelected = condition;
      _countriesSelected =  country;
      _selectedGender = gender;
      _height = height;
      _weight = weight;
      _isLoading = false;
    });
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
            Center(
              child: Container(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width < 500 ? 20.0 : 60.0),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 20.0,),
                              Center(
                                child: Text(_translate('setup_title'), style: TextStyle(fontSize: 30, letterSpacing: 5.0,fontFamily: 'MontserratBold')),
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(_translate('setup_gender'), style: TextStyle(fontSize: 17.0)),
                                    SizedBox(height: 5.0),
                                    _getGender(_selectedGender, bloc),
                                    SizedBox(height: 20.0),
                                    Text(_translate('setup_birthdate'), style: TextStyle(fontSize: 17.0)),
                                    SizedBox(height: 5.0),
                                    _birthDatePicker(screenSize),
                                    SizedBox(height: 20.0),
                                    Text(_translate('setup_height'), style: TextStyle(fontSize: 17.0)),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 170,
                                          child: _heightField(bloc),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text('cm', style: TextStyle(fontSize: 17.0),)
                                      ],
                                    ),
                                    Text(_translate('setup_weight'), style: TextStyle(fontSize: 17.0)),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 170.0,
                                          child: _weightField(bloc),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text('kg', style: TextStyle(fontSize: 17.0))
                                      ],
                                    ),
                                    Text(_translate('setup_country'), style: TextStyle(fontSize: 17.0),),
                                    SizedBox(height: 5.0,),
                                    _countrySelector(bloc),
                                    SizedBox(height: 20.0,),
                                    Text(_translate('setup_medical_condition'), style: TextStyle(fontSize: 17.0),),
                                    SizedBox(height: 5.0,),
                                    _medicalConditionSelector(bloc),
                                    SizedBox(height: 60.0),
                                    _submitButton(bloc),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _noInfo == true
            ? SizedBox()
            : AppBackButton(),
            _isLoading ? 
            Container(
                  color: Colors.black45,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ) 
            :
            Container()
          ],
        )
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  Widget _countrySelector(SetupBloc bloc){
    return StreamBuilder(
      stream: bloc.countryStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 30,
            underline: Container(
              height: 0,
            ),
            items: _countries.map((String dropDownStringItem){
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: bloc.changeCountry,
            value: bloc.country != null ? bloc.country : _countriesSelected,
          ),
        );
      },
    );
  }

  Widget _medicalConditionSelector(SetupBloc bloc){
    return StreamBuilder(
      stream: bloc.medicalConditionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 30,
            underline: Container(
              height: 0,
            ),
            items: _medicalCondition.map((String dropDownStringItem){
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: bloc.changeMedicalCondition,
            value: bloc.medicalCondition != null ? bloc.medicalCondition : _medicalConditionSelected,
          ),
        );
      },
    );
  }

  Widget _buttonGenderSelected(name, onPress){
    return Container(
      height: 45.0,
      child: FlatButton(
        onPressed: (){
          setState(() {
            _selectedGender = onPress;
          });
        },
        child: Text(name, style: TextStyle(
            color: Colors.white
          )
        ),
        color: Colors.black38,
        shape: RoundedRectangleBorder(
          side: BorderSide(
          color: Colors.white,
          width: 2,
          style: BorderStyle.solid
        ), 
        borderRadius: BorderRadius.circular(10)
        ),
      )
    );
  }

  Widget _buttonGender(name, onPress, SetupBloc bloc){
    return StreamBuilder(
      stream: bloc.genderStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          height: 45.0,
          child: FlatButton(
            onPressed: (){
              bloc.changeGender(onPress);
              setState(() {
                _selectedGender = onPress;
              });
            },
            child: Text(name, style: TextStyle(
                color: Colors.white
              )
            ),
            color: Colors.black38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
          )
        );
      },
    );
  }

  Widget _getGender(_selectedGender, SetupBloc bloc){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _selectedGender == 'FEMALE' ?
          _buttonGenderSelected(_translate('setup_female'), null)
          : _buttonGender(_translate('setup_female'), 'FEMALE', bloc), 
        _selectedGender == 'MALE' ?
          _buttonGenderSelected(_translate('setup_male'), null)
          : _buttonGender(_translate('setup_male'), 'MALE', bloc),
        _selectedGender == 'OTHER' ?
          _buttonGenderSelected(_translate('setup_other'), null)
          : _buttonGender(_translate('setup_other'), 'OTHER', bloc)
      ],
    );
  }

  Widget _birthDatePicker(screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          elevation: 0.0,
          onPressed: () {
            DatePicker.showDatePicker(
              context, 
              theme: DatePickerTheme(containerHeight: 210.0),
              showTitleActions: true,
              minTime: DateTime(1920, 1, 1),
              maxTime: DateTime.now(),
              onConfirm: (date){
                setState(() {
                  _birthDate = date;
                });
              },
              currentTime: _birthDate,
              locale: LocaleType.es
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${_birthDate.year} - ${_birthDate.month} - ${_birthDate.day}',
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(width: 10.0),
                Text(
                  _translate('change_button'),
                  style: TextStyle(
                    fontSize: 16.0
                  )
                )
              ],
            ),
          ),
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _heightField(SetupBloc bloc) {
    return StreamBuilder(
      stream: bloc.heightStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          hintText: _height,
          focusNode: _focusNode,
          bloc: bloc,
          snapshot: snapshot,
          textType: TextInputType.number,
          onChange: bloc.changeHeight,
        );
      },
    );
  }

  Widget _weightField(SetupBloc bloc){
    return StreamBuilder(
      stream: bloc.weightStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return AppTextField(
          hintText: _weight,
          bloc: bloc,
          snapshot: snapshot,
          textType: TextInputType.number,
          onChange: bloc.changeWeight,
        );
      },
    );
  }

  Widget _submitButton(SetupBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: AppButton(
            color: Colors.black38,
            name: _translate('save_button'),
            textStyle: TextStyle(fontSize: 17, color: Colors.white),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });

              String gender = _selectedGender;
              DateTime birthdate = _birthDate;
              String height = _height;
              String weight = _weight;
              String country = _countriesSelected;
              String disease = _medicalConditionSelected;


              if(bloc.gender != null){
                gender = bloc.gender;
              }
              if(bloc.birth != null){
                birthdate = bloc.birth;
              }
              if(bloc.height != null){
                height = bloc.height;
              }
              if(bloc.weight != null){
                weight = bloc.weight;
              }
              if(bloc.country != null){
                country = bloc.country;
              }
              if(bloc.medicalCondition != null){
                disease = bloc.medicalCondition;
              }


                String formattedBirthDate = DateFormat('yyyy-MM-dd').format(birthdate);
                Map setupInfo = await _usersProvider.setup(gender, formattedBirthDate, height, weight, country, disease);

                if(setupInfo['ok']){
                  setState(() {
                    _isLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(
                    _showSuccessSnackBar(_translate('save_data_success'))
                  );
                  Timer(Duration(seconds: 2), () {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> r) => false);
                  });
                }else{
                  setState(() {
                    _isLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(
                    _showSnackBar(_translate(setupInfo['message']))
                  );
                }
            },
          )
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

  Widget _showSuccessSnackBar(translation){
      return SnackBar(
        duration: Duration(seconds: 2),
        content: Container(
          height: 40.0,
          child: Center(child: Text(translation, style: TextStyle(color: Color(0xff8AF9FF)))),
        ),
    );
  }
}
