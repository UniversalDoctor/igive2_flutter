import 'package:flutter/material.dart';

void showAlert(BuildContext context, String title, String message){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('ok', style: TextStyle(color: Colors.black),),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}