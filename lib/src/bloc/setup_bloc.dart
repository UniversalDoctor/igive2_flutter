import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:igive2/src/utils/validations.dart';

class SetupBloc with ValidationFields{
  BehaviorSubject<String> _genderController;
  BehaviorSubject<DateTime> _birthController;
  BehaviorSubject<String> _heightController;
  BehaviorSubject<String> _weightController;
  BehaviorSubject<String> _countryController;
  BehaviorSubject<String> _medicalConditionController;

  init(){
    resetControllers();
  }

  Stream<String> get genderStream => _genderController.stream.transform(validateGender);
  Stream<DateTime> get birthStream => _birthController.stream.transform(validateBirth);
  Stream<String> get heightStream => _heightController.stream.transform(validateHeight);
  Stream<String> get weightStream => _weightController.stream.transform(validateWeight);
  Stream<String> get countryStream => _countryController.stream.transform(validateCountry);
  Stream<String> get medicalConditionStream => _medicalConditionController.stream.transform(validateMedicalCondition);

  Stream<bool> get formValidStream => Observable.combineLatest6(genderStream, heightStream, weightStream, birthStream, countryStream, medicalConditionStream, (g, h, w, b, c, m) => true);

  Function(String) get changeGender => _genderController.sink.add;
  Function(DateTime) get changeBirth => _birthController.sink.add;
  Function(String) get changeHeight => _heightController.sink.add;
  Function(String) get changeWeight => _weightController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeMedicalCondition => _medicalConditionController.sink.add;

  String get gender => _genderController.value;
  DateTime get birth => _birthController.value;
  String get height => _heightController.value;
  String get weight => _weightController.value;
  String get country => _countryController.value;
  String get medicalCondition => _medicalConditionController.value;

  resetControllers(){
    _genderController = BehaviorSubject<String>();
    _birthController = BehaviorSubject<DateTime>();
    _heightController = BehaviorSubject<String>();
    _weightController = BehaviorSubject<String>();
    _countryController = BehaviorSubject<String>();
    _medicalConditionController = BehaviorSubject<String>();
  }
  dispose(){
    _genderController?.close();
    _birthController?.close();
    _heightController?.close();
    _weightController?.close();
    _countryController?.close();
    _medicalConditionController?.close();
  }
}