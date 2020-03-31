import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igive2/src/translations.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';

class AppQuestBackButton extends StatefulWidget {
  
  @override
  _AppQuestBackButtonState createState() => _AppQuestBackButtonState();
}

class _AppQuestBackButtonState extends State<AppQuestBackButton> {
  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: 10,
      top: 10,
      child: SafeArea(
        child: CupertinoButton(
          padding: EdgeInsets.all(10.0),
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black26,
          onPressed: () => _showLeaveDialog(context),
          // child: Icon(Icons.arrow_back, color: Colors.white,),
          child: Image.asset(
            'assets/img/3.0x/Flecha_2blanco.png',
            fit: BoxFit.cover,
            height: 20.0,
          ),
        ),
      )
    );
  }

  _showLeaveDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xfffaf8f6),
          title: Text(_translate('leave_questionnaire_title'), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18)),
          content: Text('${_translate("leave_questionnaire_body")}\n\n${_translate('leave_questionnaire_body_2')}', textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
          actions: <Widget>[
            AppButton(
              color: Colors.blueAccent[100],
              name: _translate('leave_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            AppButton(
              color: Color(0xffff9292),
              name: _translate('cancel_button'),
              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }
}