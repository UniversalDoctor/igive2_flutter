import 'package:flutter/material.dart';

class AppButtonBorder extends StatelessWidget {

  final String name;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final double radius;
  final double height;

  const AppButtonBorder({Key key, this.name, this.onPressed, this.textStyle, this.radius, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white
        ),
        borderRadius: BorderRadius.circular(radius != null ? radius : 10.0)
      ),
      height: height != null ? height : 40.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius != null ? radius : 10.0),
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: 
          textStyle != null ?
          textStyle
          :
          TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'MontserratBold'
          )
        ),
        onPressed: onPressed,
      ),
    );
  }
}