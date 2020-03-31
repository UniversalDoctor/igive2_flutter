import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class LoginBloc with ValidationFields{
  BehaviorSubject<String> _emailController;
  BehaviorSubject<String> _passwordController;
  
  init(){
    resetControllers();
  }

  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream => Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

  resetControllers(){
    _emailController = BehaviorSubject<String>();
    _passwordController = BehaviorSubject<String>();
  }
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}