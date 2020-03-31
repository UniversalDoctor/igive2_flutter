import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final Color color;
  final String name;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final double radius;
  final double height;

  const AppButton({this.color, this.onPressed, this.name, this.textStyle, this.radius, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(radius != null ? radius : 10.0),
        child: SizedBox(
          height: height != null ? height : 40.0,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)
              ),
              disabledColor: Colors.blueGrey,
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
        ),
      ),
    );
  }
}
