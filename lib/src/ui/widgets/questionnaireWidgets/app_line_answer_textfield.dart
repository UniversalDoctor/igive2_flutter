import 'package:flutter/material.dart';

class AppLineAnswerTextfield extends StatelessWidget {

  final Map question;
  final FocusNode focusNode;
  final Function onChange;
  final TextEditingController controller;
  final String questionType;

  const AppLineAnswerTextfield({Key key, this.question, this.focusNode, this.onChange, this.controller, this.questionType});


  @override
  Widget build(BuildContext context) {
    if(questionType == 'FREEANSWER'){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              question['questions'],
              style: TextStyle(

              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            // keyboardType: TextInputType.number,
            cursorColor: Color(0xff363636),
            focusNode: focusNode,
            style: TextStyle(
              color: Colors.black
            ),
            controller: controller,
            decoration: InputDecoration(
              hintText: question['answer'],
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0
                )
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)
            ),
            onChanged: onChange,
          )
        ],
      );
    }else if(questionType == 'FREELONGANSWER'){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              question['questions'],
              style: TextStyle(

              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            maxLines: null,
            cursorColor: Color(0xff363636),
            focusNode: focusNode,
            style: TextStyle(
              color: Colors.black
            ),
            controller: controller,
            decoration: InputDecoration(
              hintText: question['answer'],
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0
                )
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)
            ),
            textCapitalization: TextCapitalization.sentences,
            onChanged: onChange,
          )
        ],
      );
    }
  }
}