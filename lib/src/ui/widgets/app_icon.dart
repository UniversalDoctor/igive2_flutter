import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {

  final double size;

  const AppIcon({this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      // padding: EdgeInsets.only(top: 20.0),
      // child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/img/3.0x/logo.png'),
            fit: BoxFit.cover,
            height: size,
          ),
        ],
      // )
    );
  }
}