import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class AddStudyBloc with ValidationFields{
  BehaviorSubject<String> _codeController;

  init(){
    resetControllers();
  }

  Stream<String> get codeStream => _codeController.stream.transform(validateStudyCode);

  Function(String) get changeCode => _codeController.sink.add;

  String get code => _codeController.value;

  resetControllers(){
    _codeController = BehaviorSubject<String>();
  }
  dispose(){
    _codeController?.close();
  }
}