import 'dart:async';


class ValidationFields{
  
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('validation_email');
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      Pattern pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = new RegExp(pattern);

      // if(regExp.hasMatch(password)){
      //   sink.add(password);
      // }else{
      //   sink.addError('validation_password');
      // }
      if(password.length <= 5){
        sink.addError('validation_password');
      }else{
        sink.add(password);
      }
    }
  );

  final validateRepPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (repPassword, sink){
      Pattern pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      RegExp regExp = RegExp(pattern);

      // if(regExp.hasMatch(repPassword)){
      //   sink.add(repPassword);
      // }else{
      //   sink.addError('validation_password');
      // }
      if(repPassword.length <= 5){
        sink.addError('validation_password');
      }else{
        sink.add(repPassword);
      }
    }
  );


  final validateBirth = StreamTransformer<DateTime, DateTime>.fromHandlers(
    handleData: (validateBirth, sink){
      sink.add(validateBirth);
    }
  );

  final validateNewsletter = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (newsletter, sink){
        sink.add(newsletter);
    }
  );


  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink){
      if(name.length > 0){
        sink.add(name);
      }else{
        sink.addError('validation_name');
      }
    }
  );

  final validateLastName = StreamTransformer<String, String>.fromHandlers(
    handleData: (lastName, sink){
      if(lastName.length > 0){
        sink.add(lastName);
      }else{
        sink.addError('validation_last_name');
      }
    }
  );

  final validateStudyCode = StreamTransformer<String, String>.fromHandlers(
    handleData: (code, sink){
      if(code.length <= 0){
        sink.addError('validation_empty');
      }else{
        sink.add(code);
      }
    }
  );

  final validateHighHypertension = StreamTransformer<String, String>.fromHandlers(
    handleData: (hypertension, sink){
      print('hello');
      final n = num.tryParse(hypertension);
      if(n == null){
        sink.addError('hypertension_incorrect_value');
      }else{
        if(hypertension.length <= 0){
          sink.addError('hypertension_empty_fields');
        }else{
          sink.add(hypertension);
        }
      }
    }
  );
  
  final validateLowHypertension = StreamTransformer<String, String>.fromHandlers(
    handleData: (hypertension, sink){
      final n = num.tryParse(hypertension);
      print(n);
      if(n == null){
        sink.addError('hypertension_incorrect_value');
      }else{
        if(hypertension.length <= 0){
          sink.addError('hypertension_empty_fields');
        }else{
          sink.add(hypertension);
        }
      }
    }
  );

  final validateHeight = StreamTransformer<String, String>.fromHandlers(
    handleData: (height, sink){
      final n = num.tryParse(height);
      if(n == null){
        sink.addError('validation_valid_value');
      }else{
        if(height.length <= 0){
          sink.addError('validation_empty');
        }else{
          if(n > 250 || n < 50){
            sink.addError('validation_valid_value');
          }else{
              sink.add(height);
          }
        }
      }
    }
  );

  final validateWeight = StreamTransformer<String, String>.fromHandlers(
    handleData: (weight, sink){
      final n = num.tryParse(weight);
      print(n);
      if(n == null){
        sink.addError('validation_valid_value');
      }else{
        if(weight.length <= 0){
          sink.addError('validation_empty');
        }else{
          if(n > 250 || n < 30){
            sink.addError('validation_valid_value');
          }else{
            sink.add(weight);
          }
        }
      }
    }
  );

  final validateGender = StreamTransformer<String, String>.fromHandlers(
    handleData: (gender, sink){
      if(gender.length > 0){
        sink.add(gender);
      }else{
        sink.addError('validation_empty');
      }
    }
  );

  final validateCountry = StreamTransformer<String, String>.fromHandlers(
    handleData: (country, sink){
      if(country.length > 0){
        sink.add(country);
      }else{
        sink.addError('validation_empty');
      }
    }
  );

  final validateMedicalCondition = StreamTransformer<String, String>.fromHandlers(
    handleData: (medicalCondition, sink){
      if(medicalCondition.length > 0){
        sink.add(medicalCondition);
      }else{
        sink.addError('validation_empty');
      }
    }
  );

  final validateStatus = StreamTransformer<String, String>.fromHandlers(
    handleData: (status, sink){
      sink.add(status);
    }
  );

  final validateAnswers = StreamTransformer<Map, Map>.fromHandlers(
    handleData: (answers, sink){
      sink.add(answers);
    }
  );
}