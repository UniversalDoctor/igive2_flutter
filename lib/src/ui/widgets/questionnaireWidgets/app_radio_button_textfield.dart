import 'package:flutter/material.dart';

class AppRadioButtonTextfield extends StatefulWidget {
  
  final Map question;
  final FocusNode focusNode;
  final Function onChange;
  final TextEditingController controller;

  const AppRadioButtonTextfield({Key key, this.question, this.focusNode, this.onChange, this.controller}) : super(key: key);

  @override
  _AppRadioButtonTextfieldState createState() => new _AppRadioButtonTextfieldState();
}

class _AppRadioButtonTextfieldState extends State<AppRadioButtonTextfield> {

  int group = 0;
  List optionsList = [];
  List optionsTitles = ['Checkbox 1', 'Checkbox 2', 'Checkbox 3'];

  @override
  void initState(){
    _addDynamic();
    super.initState();
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
        new Radio(
          value: i,
          groupValue: group,
          onChanged: (T){
            setState((){
              group = T;
            });
            _addDynamic();
          },
        ),
        new Text(
          optionsTitles[i],
          style: new TextStyle(fontSize: 16.0),
        ),
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
                itemBuilder: (_, index) => optionsList[index],
              ),
            )
            // Row(
            //   children: <Widget>[
            //     new Radio(
            //       value: 0,
            //       groupValue: group,
            //       onChanged: (T){
            //         setState((){
            //           group = T;
            //         });
            //       },
            //     ),
            //     new Text(
            //       'Carnivore',
            //       style: new TextStyle(fontSize: 16.0),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     new Radio(
            //       value: 1,
            //       groupValue: group,
            //       onChanged: (T){
            //         setState((){
            //           group = T;
            //         });
            //       },
            //     ),
            //     new Text(
            //       'Herbivore',
            //       style: new TextStyle(
            //         fontSize: 16.0,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     new Radio(
            //       value: 2,
            //       groupValue: group,
            //       onChanged: (T){
            //         setState((){
            //           group = T;
            //         });
            //       },
            //     ),
            //     new Text(
            //       'Omnivore',
            //       style: new TextStyle(fontSize: 16.0),
            //     ),
            //   ],
            // )
          ],
        ),
      ],
    );
  }
}