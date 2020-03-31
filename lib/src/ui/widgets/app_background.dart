import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.5),
          end: FractionalOffset(0.5, 1.0),
          // ---------- Verde ----------
          // colors: [
          //   Color(0xff80B4A1),
          //   Color(0xff5D917C),
          // ]
          // ---------- Azul ----------
          colors: [
            Color(0xff7BA8CD),
            Color(0xff395491)
          ]
          // ---------- Morado ----------
          // colors: [
          //   Color(0xffB59ED1),
          //   Color(0xff7578B0),
          // ]
        )
      ),
    );
  }
}