import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: 10,
      top: 10,
      child: SafeArea(
        child: CupertinoButton(
          padding: EdgeInsets.all(10.0),
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black26,
          onPressed: ()=>Navigator.pop(context),
          // child: Icon(Icons.arrow_back, color: Colors.white,),
          child: Image.asset(
            'assets/img/3.0x/Flecha_2blanco.png',
            fit: BoxFit.cover,
            height: 20.0,
          ),
        ),
      )
    );
  }
}