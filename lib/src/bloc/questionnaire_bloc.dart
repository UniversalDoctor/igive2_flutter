import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class QuestionnaireBloc with ValidationFields{
  BehaviorSubject<Map> _answersController;

  init(){
    resetControllers();
  }

  Stream<Map> get answersStream => _answersController.stream.transform(validateAnswers);

  Function(Map) get changeAnswers => _answersController.sink.add;

  Map get answers => _answersController.value;


  resetControllers(){
    _answersController = BehaviorSubject<Map>();
  }

  dispose(){
    _answersController?.close();
  }
}