import 'dart:async';

import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/providers/study_provider.dart';

import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/questionnaireWidgets/app_checkbox_textfield.dart';
import 'package:igive2/src/ui/widgets/questionnaireWidgets/app_quest_back_button.dart';
import 'package:igive2/src/ui/widgets/questionnaireWidgets/app_line_answer_textfield.dart';
import 'package:igive2/src/translations.dart';
import 'package:igive2/src/ui/widgets/questionnaireWidgets/app_radio_button_textfield.dart';

class QuestionnaireScreen extends StatefulWidget {

  final String formId;
  final String participantId;

  const QuestionnaireScreen({Key key, this.formId, this.participantId}) : super(key: key);

  static const String routeName = '/questionnaire';
  @override
  _QuestionnaireScreenState createState() => new _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {

  final _studyProvider = StudyProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = Provider.questionnaireBloc();
  List listDynamic = [];
  TextEditingController controller = new TextEditingController();
  List answers = [];
  List responses = [];
  bool created;
  bool _isLoading = false;
  List form = [];

  @override
  void initState() {
    created = false;
    getQuestionnaire();
    bloc.resetControllers();
    // TODO: implement initState
    super.initState();
  }

  getQuestionnaire()async{
    Map questionnaireInfo = await _studyProvider.getQuestionnaire(widget.formId);
    if(questionnaireInfo['ok']){
        form.add(questionnaireInfo['info']);
        _addDynamic();
      setState(() {
        _isLoading = false;
      });
    }else{
      setState(() {
        _isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate(questionnaireInfo['message']))
      );
    }
  }

  _addDynamic(){
    listDynamic.add(_description());
    for(var i = 0; i < form[0]['responses'].length; i++){
      listDynamic.add(DynamicWidget(question: form[0]['responses'][i]));
    }
    listDynamic.add(_sendButton());
    setState(() {
      created = true;
    });
  }

  _description(){
    return Column(
      children: <Widget>[
        Center(
          child: Text('Nombre del form', style: TextStyle(fontFamily: 'MontserratSemiBold', fontSize: 20.0),)
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text('Descripcion del form', textAlign: TextAlign.justify )
        ),
        SizedBox(height: 40.0),
      ],
    );
  }

  _sendButton(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 40),
      child: AppButton(
        color: Colors.black38,
        onPressed: () {
          submitData(bloc);
          // _scaffoldKey.currentState.showSnackBar(
          //   _showSuccessSnackBar(_translate('send_data_success'))
          // );
          // Timer(Duration(seconds: 2), () {
          //   Navigator.pushNamedAndRemoveUntil(context, '/communitystudy', (Route<dynamic> r) => false);
          // });
        },
        name: _translate('form_send_button'),
      ),
    );
  }

  submitData(QuestionnaireBloc bloc){
    setState(() {
      _isLoading = true;
      answers = [];
      responses = [];
    });
    // listDynamic.forEach((widget) => print((widget.controller.text)));
    listDynamic.forEach((widget) {
      try {
        answers.add((widget.controller.text));
      } catch (e) {
      }
    });
    
    for(var i = 0; i < answers.length; i++){
      if(answers[i] == ''){
        _isLoading = false;
        return _scaffoldKey.currentState.showSnackBar(
          _showSnackBar(_translate('empty_questions'))
        );
      }else{
        responses.add(
          {
            'questionId': form[0]['responses'][i]['idQuestion'],
            'response': answers[i]
          }
        );
      }
    }
    Map questionnaireResponse = {
      'participantId': widget.participantId,
      'formId': form[0]['idForm'],
      'responses': responses
    };
    bloc.changeAnswers(questionnaireResponse);
    setState(() {
      _isLoading = true;
    });
    _sendQuestionnaire(bloc, questionnaireResponse);

  }

  _sendQuestionnaire(QuestionnaireBloc bloc, Map questionnaireResponse) async{
    Map questionnaireInfo = await _studyProvider.sendQuestionnaire(questionnaireResponse);
    if(questionnaireInfo['ok']){
      setState(() {
        _isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        _showSuccessSnackBar(_translate('send_data_success'))
      );
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }else{
      setState(() {
        _isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate(questionnaireInfo['message']))
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            // SingleChildScrollView(
            //     child: SafeArea(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.stretch,
            //           children: <Widget>[
            //             Center(
            //               child: Text('Nombre del form', style: TextStyle(fontFamily: 'MontserratSemiBold', fontSize: 20.0),)
            //             ),
            //             SizedBox(height: 20.0),
            //             Center(
            //               child: Text('Descripcion del form', textAlign: TextAlign.justify )
            //             ),
            //             SizedBox(height: 40.0),
                        // Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: <Widget>[
                        //     DynamicWidget(question: {'questions': 'This is a number question type, you can only anwer with numbers.', 'type': 'NUMBER'},),
                        //     Container(
                        //       margin: EdgeInsets.all(10.0),
                        //       child: AppRadioButtonTextfield(
                        //         question: {'questions': 'This is a checkbox question type, you have to chose only one answer.'},
                        //         controller: controller,
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.all(10.0),
                        //       child: AppCheckBoxTextfield(
                        //         question: {'questions': 'This is a multiple check box question type, you can chose as answers as you want.'},
                        //         controller: controller,
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.all(10.0),
                        //       child: AppLineAnswerTextfield(
                        //         question: {'questions': 'This is a free answer question type, you can write all you want.'},
                        //         controller: controller,
                        //         questionType: 'FREEANSWER' 
                        //       ),
                        //     ),
                        //     SizedBox(height: 40.0),
                        //   ],
                        // ),
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: listDynamic.length,
                                itemBuilder: (_,index) => listDynamic[index],
                              ),
                            ),
                          ],
                        ),
                        // Container(
                        // height: (listDynamic.length)*150.0,
                        //   child: Column(
                        //     children: <Widget>[
                        //       Expanded(
                        //         child: ListView.builder(
                        //           physics: const NeverScrollableScrollPhysics(),
                        //           itemCount: listDynamic.length,
                        //           itemBuilder: (_,index) => listDynamic[index],
                        //         ),
                        //       ),
                        //     ],
                        //   )
                        // ),
              //                 SizedBox(height: 40.0),
              //           SizedBox(
              //             height: 40.0,
              //           ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 50.0),
                        //   child: AppButton(
                        //     color: Colors.black38,
                        //     onPressed: () {
                        //       _scaffoldKey.currentState.showSnackBar(
                        //         _showSuccessSnackBar(_translate('send_data_success'))
                        //       );
                        //       Timer(Duration(seconds: 2), () {
                        //         Navigator.pushNamedAndRemoveUntil(context, '/communitystudy', (Route<dynamic> r) => false);
                        //       });
                        //     },
                        //     name: _translate('form_send_button'),
                        //   ),
                        // )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            AppQuestBackButton(),
            _isLoading
            ? Positioned.fill(
                child: Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
            : Container()
          ],
        ),
      ),
    );
  }
  _translate(translation){
    return Translations.of(context).text(translation);
  }
}

Widget _showSnackBar(translation){
  return SnackBar(
    duration: Duration(seconds: 2),
    content: Container(
      height: 40.0,
      child: Center(child: Text(translation, style: TextStyle(color: Color(0xffff9292)))),
    ),
  );
}
Widget _showSuccessSnackBar(translation){
    return SnackBar(
      duration: Duration(seconds: 2),
      content: Container(
        height: 40.0,
        child: Center(child: Text(translation, style: TextStyle(color: Color(0xff8AF9FF)))),
      ),
  );
}

class DynamicWidget extends StatelessWidget{

  final Map question;
  DynamicWidget({Key key, this.question}) : super(key: key);
  
  TextEditingController controller = new TextEditingController();

  List answers = [];

  @override
  Widget build(BuildContext context){
    var answerType = question['type'];

    if(answerType == 'FREEANSWER' || answerType == 'FREELONGANSWER'){
      return Container(
        margin: EdgeInsets.all(10.0),
        child: AppLineAnswerTextfield(
          question: question,
          controller: controller,
          questionType: answerType,
        ),
      );
    }else if(answerType == 'MULTIPLECHECKBOX'){
      return Container(
        margin: EdgeInsets.all(10.0),
        child: AppCheckBoxTextfield(
          question: question,
          controller: controller,
        ),
      );
    }else if(answerType == 'SINGLECHECKBOX'){
      return Container(
        margin: EdgeInsets.all(10.0),
        child: AppRadioButtonTextfield(
          question: question,
          controller: controller,
        ),
      );
    }else{
      return Container(
        margin: EdgeInsets.all(10.0),
        child: AppLineAnswerTextfield(
          question: question,
          controller: controller,
          questionType: 'FREEANSWER' 
        ),
      );
    }
  }
}