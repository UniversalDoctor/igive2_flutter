import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class EditProfileBloc with ValidationFields{
  BehaviorSubject<String> _usernameController;
  BehaviorSubject<String> _emailController;
  BehaviorSubject<String> _statusController;

  init(){
    resetController();
  }

  Stream<String> get usernameStream => _usernameController.stream.transform(validateName);
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get statusStream => _statusController.stream.transform(validateStatus);

  Stream<bool> get formValidStream => Observable.combineLatest2(usernameStream, emailStream, (u, e) => true);

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeStatus => _statusController.sink.add;

  String get username => _usernameController.value;
  String get email => _emailController.value;
  String get status => _statusController.value;

  resetController(){
    _usernameController = BehaviorSubject<String>();
    _emailController = BehaviorSubject<String>();
    _statusController = BehaviorSubject<String>();
  }
  dispose(){
    _usernameController?.close();
    _emailController?.close();
    _statusController?.close();
  }
}