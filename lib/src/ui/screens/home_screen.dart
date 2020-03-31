import 'package:flutter/material.dart';
import 'package:igive2/src/ui/screens/community/community_study_screen.dart';
import 'package:igive2/src/ui/screens/home/journey_screen.dart';
import 'package:igive2/src/ui/screens/settings/settings_screen.dart';
import 'package:igive2/src/ui/screens/statistics/statistics_screen.dart';


class HomeScreen extends StatefulWidget {
  
  static const String routeName = '/home';
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  Widget _callPage(int paginaActual){
    switch( paginaActual){
      case 0: return CommunityStudyScreen();
      case 1: return JourneyScreen();
      case 2: return StatisticsScreen();
      case 3: return SettingsScreen();

      default: return StatisticsScreen();
    }
  }

  Widget _bottomNavigationBar(BuildContext context){

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.blueAccent,
        textTheme: Theme.of(context).textTheme
          .copyWith(caption: TextStyle(color: Colors.blueGrey))
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Color(0xffF0EDEB),
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: currentIndex == 0? new Image.asset('assets/img/3.0x/GroupOn.png', color: Colors.blueAccent, height: 30,):new Image.asset('assets/img/3.0x/GroupOn.png', color: Colors.black, height: 30,),
              title: Text('Community', style: TextStyle(fontFamily: 'MontserratLight', color: Colors.black),),
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: currentIndex == 1? new Image.asset('assets/img/3.0x/ExcerciseON.png', color: Colors.blueAccent, height: 30,):new Image.asset('assets/img/3.0x/ExcerciseON.png', color: Colors.black, height: 30,),
              title: Text('Home', style: TextStyle(fontFamily: 'MontserratLight', color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 2? new Image.asset('assets/img/3.0x/StaticsOn.png', color: Colors.blueAccent, height: 30,):new Image.asset('assets/img/3.0x/StaticsOn.png', color: Colors.black, height: 30,),
            title: Text('Stats', style: TextStyle(fontFamily: 'MontserratLight', color: Colors.black),)
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 3? new Image.asset('assets/img/3.0x/SettingsON.png', color: Colors.blueAccent, height: 30,):new Image.asset('assets/img/3.0x/SettingsON.png', color: Colors.black, height: 30,),
            title: Text('Settings', style: TextStyle(fontFamily: 'MontserratLight', color: Colors.black),)
          ),
        ]
      ),
    );
  }
}