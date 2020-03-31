import 'package:flutter/material.dart';

import 'package:flutter_event_bus/flutter_event_bus.dart';
import 'package:flutter_event_bus/flutter_event_bus/EventBus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:igive2/src/providers/study_provider.dart';

import 'package:igive2/src/translations.dart';
import 'package:igive2/src/ui/screens/community/questionnaire_screen.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button_border.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button_check.dart';

class StudyDetailScreen extends StatefulWidget {
 
  final Map study;
  final List details;
  final int selected;

  const StudyDetailScreen({Key key, this.study, this.details, this.selected,}) : super(key: key);

  @override
  _StudyDetailScreenState createState() => _StudyDetailScreenState();
}

class _StudyDetailScreenState extends State<StudyDetailScreen> {
  
  List dynamicQuestionnaires = [];
  List dynamicSharedData = [];
  List studySharedData = [];
  Map studyDetails = {};


  @override
  void initState(){
    super.initState();
  }

  addDynamicQuestionnaire() async {
    dynamicQuestionnaires.clear();
    if(widget.details[widget.selected]['formsMobile'].length != 0){
      for(var i = 0; i < widget.details[widget.selected]['formsMobile'].length; i++){
        dynamicQuestionnaires.add(_addDynamicQuestionnaire(i));
        dynamicQuestionnaires.add(SizedBox(height: 5.0));
      }

    }
  }


  addDynamicSharedData(){
    String a = widget.details[widget.selected]['requestedData'].replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    List ab = (a.split(','));
    studySharedData.clear();
    for(var i = 0; i < ab.length; i++){
      if(ab[i] != 'DYASTOLIC'){
        studySharedData.add(ab[i]);
      }
    }
    dynamicSharedData.clear();
    if(studySharedData.length != 0 && studySharedData[0] != ''){
      for(var i = 0; i < studySharedData.length; i++){
        dynamicSharedData.add(_addSharedData(i));
        dynamicSharedData.add(SizedBox(width: 25.0));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    addDynamicQuestionnaire();
    addDynamicSharedData();
    final screenSize = MediaQuery.of(context).size;
    final divide = (screenSize.width / 3);

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          _testInfo(),
          SizedBox(height: 20.0),
          _userInfo(screenSize),
          SizedBox(height: 20.0),
          _actionsItems(screenSize),
          // SizedBox(height: 20.0),
          // _news(screenSize),
          SizedBox(height: 20.0),
          dynamicSharedData.length > 0 
            ? _sharingContent(divide)
            : Container(),
          SizedBox(height: 20.0),
          // _institutions(),
          SizedBox(height: 20.0),
          _otherActions(divide),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  _addDynamicQuestionnaire(i){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        child: AppButtonCheck(
          check: widget.details[widget.selected]['formsMobile'][i]['completed'],
          color: Color(0xfffaf8f6),
          name: widget.details[widget.selected]['formsMobile'][i]['name'],
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new QuestionnaireScreen(formId:widget.details[widget.selected]['formsMobile'][i]['id'], participantId: '5e37cfdc8b3fe50004518ebe')));
                    //TODO:: participant id
          },
          radius: 20.0,
          height: 35.0,
          textStyle: TextStyle(
            color: widget.details[widget.selected]['formsMobile'][i]['completed']
              ? Colors.green
              : Color(0xff235577),
            fontFamily: 'MontserratSemiBold',
            fontSize: 17.0
          ),
        ),
      )
    );
  }
  _addSharedData(i){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _imagen(i),
          SizedBox(height: 10.0),
          Text(
            _translate(studySharedData[i].toString()),
            style: TextStyle(
              fontSize: 15.0
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  _imagen(i){
    if(studySharedData[i] == 'STEPS'){
      return Image.asset(
        'assets/img/3.0x/steps.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'WEIGHT'){
      return Image.asset(
        'assets/img/3.0x/weight.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'HEIGHT'){
      return Image.asset(
        'assets/img/3.0x/Altura.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'ACTIVETIME'){
      return Image.asset(
        'assets/img/3.0x/steps.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'SEATEDTIME'){
      return Image.asset(
        'assets/img/3.0x/steps.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'SYSTOLIC' || studySharedData[i] == 'DYASTOLIC' || studySharedData[i] == 'BLOODPRESSURE'){
      return Image.asset(
        'assets/img/3.0x/Blood.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'BREATHINGPATTERN'){
      return Image.asset(
        'assets/img/3.0x/Respiracion.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'SLEEP'){
      return Image.asset(
        'assets/img/3.0x/steps.png',
        height: 40,
      );
    } else if(studySharedData[i] == 'HEARTRATE'){
      return Image.asset(
        'assets/img/3.0x/pulso.png',
        height: 40,
      );
    }
      return Image.asset(
        'assets/img/3.0x/steps.png',
        height: 40,
      );
  }

  Widget _testInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            widget.details[widget.selected]['name'], 
            style: TextStyle(
              fontFamily: 'MontserratBold',
              fontSize: 30.0
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.details[widget.selected]['description'],
              textAlign: TextAlign.justify,
            )
          )
        ],
      ),
    );
  }

  Widget _userInfo(screenSize){
    return Container(
      color: Colors.black38,
      width: screenSize.width,

      child: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: <Widget>[
              Text(
                '${_translate('studies_user')}: ',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'MontserratSemiBold'
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                widget.study['anonymousIdParticipant'],
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'MontserratLight'
                ),
              )
            ],
          )
        ),
      ),
    );
  }

   Widget _actionsItems(screenSize){
     
    if(widget.details[widget.selected]['formsMobile'].length == 0 && dynamicQuestionnaires.length == 0){
      return SizedBox();
    }else{
      return Container(
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _translate('studies_action_items'),
              style: TextStyle(
                fontFamily: 'MontserratBold',
                fontSize: 20.0
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: widget.details[widget.selected]['formsMobile'].length > 0 ? (widget.details[widget.selected]['formsMobile'].length) * 40.0 : 40,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dynamicQuestionnaires.length,
                itemBuilder: (_,index) => dynamicQuestionnaires[index],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _news(screenSize){
    if(6 == 0){
      return SizedBox();
    }else{
      return Container(
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'News',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'MontserratBold'
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(5.0),
              // color: Color(0xff235577),
              color: Colors.black38,
              width: screenSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'First data of the study has been analyzed and sent to publish',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'read more +',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.all(5.0),
              // color: Color(0xff235577),
              color: Colors.black38,
              width: screenSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'First data of the study has been analyzed and sent to publish',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'read more +',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _sharingContent(divide) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _translate('studies_sharing_title'),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 10.0),
            dynamicSharedData.length == 0 
              ? SizedBox()
              : Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dynamicSharedData.length,
                  itemBuilder: (_,index) => dynamicSharedData[index],
                ),
            )
          ],
        )
    );
  }

  Widget _institutions(){
    if(widget.details[widget.selected]['study']['institutions'].length == 0){
      return SizedBox();
    }else{
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                _translate('studies_institutions_title'),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 80.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10.0,),
                  Container(
                    child: Material(
                      color: Colors.transparent,
                      child: FlatButton(
                        // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                        shape: CircleBorder(),
                        highlightColor:  Colors.transparent,
                        splashColor: Colors.transparent,

                        onPressed: () => Navigator.pushNamed(context, '/addstudy'),
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset(
                          "assets/logos/logo1.png",
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    child: Material(
                      color: Colors.transparent,
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: (){},
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset(
                          "assets/logos/logo2.png",
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    child: Material(
                      color: Colors.transparent,
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: (){},
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset(
                          "assets/logos/logo2.png",
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _otherActions(divide){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: divide - 10,
                child: AppButtonBorder(
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat'
                  ),
                  height: 60.0,
                  name: _translate('studies_leave_button'),
                  onPressed: () => EventBus.publishTo(context, StudyDetailScreen()),
                ),
              ),
              Container(
                width: divide - 10,
                child: AppButtonBorder(
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat'
                  ),
                  height: 60.0,
                  name: _translate('studies_info_button'),
                  onPressed: (){},
                ),
              ),
              Container(
                width: divide - 10,
                child: AppButtonBorder(
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat'
                  ),
                  height: 60.0,
                  name: _translate('studies_email_button'),
                  onPressed: ()async{
                    final Email email = Email(
                      recipients: [widget.details[widget.selected]['contactEmail']],
                      isHTML: false,
                    );
                    await FlutterEmailSender.send(email);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}