import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> countries;

void loadCountries() async {

  //to prevent error in main before runapp(initializing flutter)
  WidgetsFlutterBinding.ensureInitialized();

  String jsonStr = await rootBundle.loadString('assets/countries.json');
  Map<String, dynamic> json = jsonDecode(jsonStr);
  countries = json.values.toList().cast<String>();
  // countries.sort();
}