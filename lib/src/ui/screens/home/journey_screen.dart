import 'package:flutter/material.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';

class JourneyScreen extends StatefulWidget {

  static const String routeName = '/journey';

  @override
  _JourneyScreenState createState() => new _JourneyScreenState();
 }

class _JourneyScreenState extends State<JourneyScreen> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          AppBackground(),
          SingleChildScrollView(
            child: Container(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'YOUR MEDALS',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'MontserratBold'
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/medals/1-Account_creator.png', fit: BoxFit.cover,
                          ),
                          width: screenSize.width / 2.5 ,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(35))
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'assets/medals/2.Data_Collector.png', fit: BoxFit.cover,
                          ),
                          width: screenSize.width / 2.5 ,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(35))
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/medals/3-Research_collaborator.png', fit: BoxFit.cover,
                          ),
                          width: screenSize.width / 2.5 ,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(35))
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/4-Known_face.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/5-10k.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/6-Connectivity_beginner.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/7-50k.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/8-Runing_Master.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/9-rocket_panda.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/medals/10-Rocking_Rocket_Panda.png', fit: BoxFit.cover,
                              ),
                              width: screenSize.width / 2.5 ,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            ),
                            Container(
                              width: screenSize.width / 2.5,
                              height: screenSize.width / 2.5 - 14,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}