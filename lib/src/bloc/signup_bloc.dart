import 'dart:async';
import 'package:igive2/src/utils/validations.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc with ValidationFields{

  BehaviorSubject<String> _nameController;
  BehaviorSubject<String>  _lastNameController;
  BehaviorSubject<String>  _emailController;
  BehaviorSubject<String>  _passwordController;
  BehaviorSubject<String>  _repPasswordController;
  BehaviorSubject<bool>  _newsletterController;

  init(){
    resetControllers();
  }

  

  Stream<String> get nameStream => _nameController.stream.transform(validateName);
  Stream<String> get lastNameStream => _lastNameController.stream.transform(validateLastName);
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  Stream<String> get repPasswordStream => _repPasswordController.stream.transform(validateRepPassword);
  Stream<bool> get newsletterStream => _newsletterController.stream.transform(validateNewsletter);

  Stream<bool> get formValidStream => Observable.combineLatest5(nameStream, lastNameStream, emailStream, passwordStream, repPasswordStream, (n, l, e, p, r) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRepPassword => _repPasswordController.sink.add;
  Function(bool) get changeNewsletter => _newsletterController.sink.add;




  String get name => _nameController.value;
  String get lastName => _lastNameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get repPassword => _repPasswordController.value;
  bool get newsletter => _newsletterController.value;

  resetControllers(){
    _nameController = BehaviorSubject<String>();
    _lastNameController = BehaviorSubject<String>();
    _emailController = BehaviorSubject<String>();
    _passwordController = BehaviorSubject<String>();
    _repPasswordController = BehaviorSubject<String>();
    _newsletterController = BehaviorSubject<bool>.seeded(false);
  }
  dispose(){
    _nameController?.close();
    _lastNameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _repPasswordController?.close();
    _newsletterController?.close();
  }
}