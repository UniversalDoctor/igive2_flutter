import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:igive2/src/providers/statistics_provider.dart';
import 'package:igive2/src/ui/screens/statistics/statistics_chart.dart';
import 'package:igive2/src/ui/screens/statistics/line_chart.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:date_util/date_util.dart';
import 'package:intl/intl.dart';

class StatisticsScreen extends StatefulWidget {

  static const String routeName = '/statistics';

  @override
  _StatisticsScreenState createState() => new _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {

  var dateUtility = new DateUtil();
  bool _isLoading = true;
  List weekSteps = [0, 0, 0, 0, 0, 0, 0];
  List monthSteps = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  final _statisticsProvider = StatisticsProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async{

    // var days = dateUtility.daysInMonth(int.parse(DateFormat('MM').format(DateTime.now())), int.parse(DateFormat('y').format(DateTime.now())));
    // print(days);
    final now = DateTime.now();

    Map statisticsWeekInfo = await _statisticsProvider.getAllDataOfDatatype('STEPS', DateFormat('y-MM-dd').format(DateTime.now()), DateFormat('y-MM-dd').format(DateTime(now.year, now.month, now.day - 6)));

    if(statisticsWeekInfo['ok']){
      weekSteps.clear();
      for(var i = 0; i < statisticsWeekInfo['info'].length; i++){
        weekSteps.add(int.parse(statisticsWeekInfo['info'][i]['vaule']));
      }
    }

    

    // Map statisticsMonthInfo = await _statisticsProvider.getAllDataOfDatatype('STEPS', DateFormat('y-MM-dd').format(DateTime.now()), DateFormat('y-MM-dd').format(DateTime(now.year, now.month-1, now.day-1)));

    // if(statisticsMonthInfo['ok']){
    //   monthSteps = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    //   for(var i = 0; i < statisticsMonthInfo['info'].length; i++){
    //     if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime.now()).toString())){
    //       monthSteps[11] = monthSteps[11] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-1, now.day)).toString())){
    //       monthSteps[10] = monthSteps[10] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;
          
    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-2, now.day)).toString())){
    //       monthSteps[9] = monthSteps[9] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-3, now.day)).toString())){
    //       monthSteps[8] = monthSteps[8] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-4, now.day)).toString())){
    //       monthSteps[7] = monthSteps[7] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-5, now.day)).toString())){
    //       monthSteps[6] = monthSteps[6] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-6, now.day)).toString())){
    //       monthSteps[5] = monthSteps[5] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-7, now.day)).toString())){
    //       monthSteps[4] = monthSteps[4] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-8, now.day)).toString())){
    //       monthSteps[3] = monthSteps[3] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-9, now.day)).toString())){
    //       monthSteps[2] = monthSteps[2] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-10, now.day)).toString())){
    //       monthSteps[1] = monthSteps[1] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }else if(statisticsMonthInfo['info'][i]['date'].contains(DateFormat('-MM-').format(DateTime(now.year, now.month-11, now.day)).toString())){
    //       monthSteps[0] = monthSteps[0] + int.parse(statisticsMonthInfo['info'][i]['value'])+.0;

    //     }
    //   }
    // }


    if(this.mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // body: Stack(
      //   children: <Widget>[
      //     AppBackground(),
      //     SingleChildScrollView(
      //       child: SafeArea(
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //               charts.LineChart(
      //                 _seriesLineData,
      //                 defaultRenderer: charts.LineRendererConfig(
      //                   includeArea: true,
      //                   stacked: true,
      //                 ),
      //                 animate: true,
      //                 animationDuration: Duration(seconds: 1),
      //               ),
      //           ],
      //         ),
      //       ),  
      //     ),
      //     _isLoading
      //     ? Container(
      //       color: Colors.black54,
      //       child: Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     )
      //     : Container()
      //   ],
      // ),
      body: Stack(
        children: <Widget>[
          AppBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 500,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('Steps of the week'),
                      Expanded(
                        child: SimpleTimeSeriesChart.withData(weekSteps),
                      )
                      //   child: charts.LineChart(
                      //     _seriesLineData,
                      //     defaultRenderer: charts.LineRendererConfig(
                      //       includeArea: true,
                      //       stacked: true,
                      //     ),
                      //     animate: true,
                      //     animationDuration: Duration(seconds: 1),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isLoading
          ? Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
          : Container()
        ],
      ),
    );
  }
}

class WeekSteps{
  DateTime dayVal;
  int stepsVal;

  WeekSteps(this.dayVal, this.stepsVal);
}