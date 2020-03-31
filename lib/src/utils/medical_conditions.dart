import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> medicalConditions;

void loadMedicalConditions() async {

  //to prevent error in main before runapp(initializing flutter)
  WidgetsFlutterBinding.ensureInitialized();

  String jsonStr = await rootBundle.loadString('assets/medicalConditions.json');
  Map<String, dynamic> json = jsonDecode(jsonStr);
  medicalConditions = json.values.toList().cast<String>();
  // countries.sort();
}