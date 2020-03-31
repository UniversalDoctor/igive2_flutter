import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class AddHypertensionValueBloc with ValidationFields{
  BehaviorSubject<String> _highPressureController;
  BehaviorSubject<String> _lowPressureController;

  init(){
    resetControllers();
  }

  Stream<String> get highPressureStream => _highPressureController.stream.transform(validateHighHypertension);
  Stream<String> get lowPressureStream => _lowPressureController.stream.transform(validateLowHypertension);

  Stream<bool> get formValidStream => Observable.combineLatest2(highPressureStream, lowPressureStream, (h, l) => true);

  Function(String) get changeHighPressure => _highPressureController.sink.add;
  Function(String) get changeLowPressure => _lowPressureController.sink.add;

  String get highPressure => _highPressureController.value;
  String get lowPressure => _lowPressureController.value;

  resetControllers(){
    _highPressureController = BehaviorSubject<String>();
    _lowPressureController = BehaviorSubject<String>();
  }
  dispose(){
    _highPressureController?.close();
    _lowPressureController?.close();
  }
}