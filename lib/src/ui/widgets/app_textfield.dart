import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igive2/src/translations.dart';

class AppTextField extends StatefulWidget {
  
  final String  hintText;
  final bool obscureText;
  final FocusNode focusNode;
  final TextInputType textType;
  final bloc;
  final AsyncSnapshot snapshot;
  final Function onChange;
  final TextCapitalization capitalization;
  final bool height;
  final bool black;
  final bool hyper;

  const AppTextField({ this.capitalization = TextCapitalization.none, this.hintText, this.obscureText, this.focusNode, this.textType, this.bloc, this.snapshot, this.onChange, this.height, this.black, this.hyper});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: TextFormField(
        cursorColor: Color(0xff363636),
        focusNode: widget.focusNode,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          helperText: '',
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          errorText: widget.snapshot.error != null ? _translate(widget.snapshot.error) : widget.snapshot.error,
          // counterText: snapshot.data,
          // counterStyle: TextStyle(color: Colors.red),
          errorStyle: TextStyle(
            color: Color(0xffff9292)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Color(0xffff9292),
              width: 2.0
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Color(0xffff9292),
              width: 2.5
            )
          ),
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: widget.hyper == true ? 14 : 16
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.black != null ? Colors.black : Colors.white,
              width: 1.0
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.black != null ? Colors.black : Colors.white,
              width: widget.black != null ? 1.5 :2.5
            )
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        ),
        textCapitalization: widget.capitalization,
        keyboardType: widget.textType == null ? TextInputType.text : widget.textType,
        onChanged: widget.onChange,
        obscureText: widget.obscureText == null ? false : widget.obscureText,
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }
}