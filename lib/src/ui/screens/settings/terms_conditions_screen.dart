import 'package:flutter/material.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/terms_conditions.dart';
import 'package:igive2/src/translations.dart';

class TermsConditionsScreen extends StatefulWidget {

  static const String routeName = '/termsconditions';

  @override
  _TermsConditionsScreenState createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 60.0),
                        Text(
                          'iGive2’s Terms Of Use',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0, 
                            fontFamily: 'MontserratBold',
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        TermsConditions(color: Colors.white,),
                        SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          AppBackButton()
        ],
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }
}