import 'package:flutter/material.dart';

class AppCheckBoxTextfield extends StatefulWidget {

  final Map question;
  final FocusNode focusNode;
  final Function onChange;
  final TextEditingController controller;

  const AppCheckBoxTextfield({Key key, this.question, this.focusNode, this.onChange, this.controller});

  @override
  _AppCheckBoxTextfieldState createState() => _AppCheckBoxTextfieldState();
}


class _AppCheckBoxTextfieldState extends State<AppCheckBoxTextfield> {
  List optionsList= [];
  Map checkboxResponses = {};
  List optionsTitles = ['1', '2', '3', '4'];

  @override
  void initState() {
    _getResponses();
    super.initState();
  }

  _getResponses(){
    checkboxResponses.clear();
    for(var i = 0; i < optionsTitles.length; i++){
      checkboxResponses[i] = false;
    }
    _addDynamic();
  }
  _addDynamic(){
    optionsList.clear();
    for(var i = 0; i < optionsTitles.length; i++){
      optionsList.add(_dynamicWidget(i));
    }
  }

  _dynamicWidget(i){
    return Row(
      children: <Widget>[
        Checkbox(
          checkColor: Colors.black87,
          value: checkboxResponses[i],
          onChanged: (bool value){
            setState(() {
              checkboxResponses[i] = value;
            });
            _addDynamic();
          },
        ),
        Text(
          optionsTitles[i],
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }


  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Text(
            widget.question['questions'],
            style: TextStyle(

            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: optionsList.length,
                itemBuilder: (_,index) => optionsList[index],
              ),
            ),
          ],
        )
      ],
    );
  }
}