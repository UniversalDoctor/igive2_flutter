import 'package:flutter/material.dart';

class AppButtonCheck extends StatelessWidget {

  final Color color;
  final String name;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final double radius;
  final double height;
  final bool check;

  const AppButtonCheck({this.color, this.onPressed, this.name, this.textStyle, this.radius, this.height, this.check});

  @override
  Widget build(BuildContext context) {
    bool questionnaireDone = false;
    if(check == null){
      questionnaireDone = false;
    }else{
      questionnaireDone = check;
    }
    return Container(
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(radius != null ? radius : 10.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onPressed,
          child: SizedBox(
            height: height != null ? height : 40.0,
            child: Stack(
              children: <Widget>[
                Center(
                  // child: FlatButton(
                  //   shape: new RoundedRectangleBorder(
                  //     borderRadius: new BorderRadius.circular(10.0)
                  //   ),
                  //   disabledColor: Colors.blueGrey,
                    child: Text(
                      name,
                      style: 
                      textStyle != null ?
                      textStyle
                      :
                      TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontFamily: 'MontserratBold'
                      ),
                    ),
                    // onPressed: onPressed,
                  // ),
                ),
                Positioned(
                    bottom: 7.0,
                    right: 20,
                    child: 
                    questionnaireDone == true ? 
                    Image.asset(
                      "assets/img/3.0x/check.png",
                      color: Colors.green,
                      height: 20.0,
                      fit: BoxFit.cover,
                    )
                    : SizedBox(),
                  )
              ],
            )
          ),
        ),
      ),
    );
  }
}
