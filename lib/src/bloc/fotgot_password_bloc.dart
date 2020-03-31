import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class ForgotPassBloc with ValidationFields{

  BehaviorSubject<String> _emailController;


  init(){
    resetControllers();
  }

  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);


  Function(String) get changeEmail => _emailController.sink.add;

  String get email => _emailController.value;

  resetControllers(){
    _emailController = BehaviorSubject<String>();
  }

  dispose(){
    _emailController?.close();
  }
}