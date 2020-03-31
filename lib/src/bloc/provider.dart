import 'package:flutter/material.dart';

import 'package:igive2/src/bloc/edit_profile_bloc.dart';
export 'package:igive2/src/bloc/edit_profile_bloc.dart';

import 'package:igive2/src/bloc/login_bloc.dart';
export 'package:igive2/src/bloc/login_bloc.dart';

import 'package:igive2/src/bloc/signup_bloc.dart';
export 'package:igive2/src/bloc/signup_bloc.dart';

import 'package:igive2/src/bloc/fotgot_password_bloc.dart';
export 'package:igive2/src/bloc/fotgot_password_bloc.dart';

import 'package:igive2/src/bloc/setup_bloc.dart';
export 'package:igive2/src/bloc/setup_bloc.dart';

import 'package:igive2/src/bloc/add_study_bloc.dart';
export 'package:igive2/src/bloc/add_study_bloc.dart';

import 'package:igive2/src/bloc/questionnaire_bloc.dart';
export 'package:igive2/src/bloc/questionnaire_bloc.dart';

import 'package:igive2/src/bloc/add_hypertension_value_bloc.dart';
export 'package:igive2/src/bloc/add_hypertension_value_bloc.dart';



class Provider extends InheritedWidget{
  static Provider _instancia;
  final _loginBloc = LoginBloc();
  final _signupBloc = SignupBloc();
  final _addStudyBloc = AddStudyBloc();
  final _forgotPassBloc = ForgotPassBloc();
  final _setupBloc = SetupBloc();
  final _editProfileBloc = EditProfileBloc();
  final _questionnaireBloc = QuestionnaireBloc();
  final _hypertensionBloc = AddHypertensionValueBloc();

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;



  static LoginBloc loginBloc (){
    return _instancia._loginBloc;
  }
  static SignupBloc signupBloc (){
    return _instancia._signupBloc;
  }
  static AddStudyBloc addStudyBloc (){
    return _instancia._addStudyBloc;
  }
  static ForgotPassBloc forgotPassBloc (){
    return _instancia._forgotPassBloc;
  }
  static SetupBloc setupBloc (){
    return _instancia._setupBloc;
  }
  static EditProfileBloc editProfileBloc (){
    return _instancia._editProfileBloc;
  }
  static QuestionnaireBloc questionnaireBloc (){
    return _instancia._questionnaireBloc;
  }
  static AddHypertensionValueBloc hypertensionBloc(){
    return _instancia._hypertensionBloc;
  }
}

