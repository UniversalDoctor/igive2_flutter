import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:igive2/src/providers/statistics_provider.dart';
import 'package:intl/intl.dart';

class StatisticsChart extends StatefulWidget {

  final List weekSteps;
  final List monthSteps;

  const StatisticsChart({Key key, this.weekSteps, this.monthSteps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StatisticsChartState();
}

class StatisticsChartState extends State<StatisticsChart> {

  bool isShowingMainData;
  final _statisticsProvider = StatisticsProvider();
  // List weekData = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  @override
  void initState() {
    super.initState();
    isShowingMainData = false;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: const [
              Colors.black54,
              Colors.black45,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 10, 
                ),
                Text(
                  isShowingMainData 
                    ? 'Steps this  month'
                    : 'Steps this week',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      isShowingMainData ? sampleData1() : sampleData2(),
                      swapAnimationDuration: Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    final now = DateTime.now();
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
        },
        handleBuiltInTouches: true,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          textStyle: TextStyle(
            // color: const Color(0xff72719b),
            fontFamily: 'Montserrat',
            fontSize: 12,
          ),
          getTitles: (value) {
            var days = 30;
            if(days == 30){
               switch (value.toInt()) {
                case 0:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 30));
                case 2:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 28));
                case 4:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 26));
                case 6:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 24));
                case 8:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 22));
                case 10:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 20));
                case 12:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 18));
                case 14:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 16));
                case 16:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 14));
                case 18:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 12));
                case 20:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 10));
                case 22:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 8));
                case 24:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 6));
                case 26:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 4));
                case 28:
                  return DateFormat('d').format(DateTime(now.year, now.month, now.day - 2));
                case 30:
                  return DateFormat('d').format(DateTime.now());
              }
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            // color: const Color(0xff75729e),
            fontFamily: 'Montserrat',
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1000:
                return '1000';
              case 2000:
                return '2000';
              case 3000:
                return '3000';
              case 4000:
                return '4000';
              case 5000:
                return '5000';
            }
            return '';
          },
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 2,
          ),
          left: BorderSide(
            color: Colors.white,
            width: 2
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 30,
      maxY: 5000,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    // LineChartBarData lineChartBarData1 = const LineChartBarData(
    //   spots: [
    //     FlSpot(1, 1),
    //     FlSpot(2, 1.5),
    //     FlSpot(3, 1.4),
    //     FlSpot(4, 3.4),
    //     FlSpot(5, 2),
    //     FlSpot(6, 2.2),
    //     FlSpot(7, 1.8),
    //   ],
    //   isCurved: true,
    //   colors: [
    //     Color(0xff4af699),
    //   ],
    //   barWidth: 8,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(
    //     show: false,
    //   ),
    // );
    // final LineChartBarData lineChartBarData2 = LineChartBarData(
    //   spots: [
    //     FlSpot(1, 1),
    //     FlSpot(3, 2.8),
    //     FlSpot(7, 1.2),
    //     FlSpot(10, 2.8),
    //     FlSpot(12, 2.6),
    //     FlSpot(13, 3.9),
    //   ],
    //   isCurved: true,
    //   colors: [
    //     Color(0xffaa4cfc),
    //   ],
    //   barWidth: 8,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(show: false, colors: [
    //     Color(0x00aa4cfc),
    //   ]),
    // );LineChartBarData(
    LineChartBarData lineChartBarData3 = LineChartBarData(
      // spots: [
      //   FlSpot(0, widget.monthSteps[0]),
      //   FlSpot(1, widget.monthSteps[1]),
      //   FlSpot(2, widget.monthSteps[2]),
      //   FlSpot(3, widget.monthSteps[3]),
      //   FlSpot(4, widget.monthSteps[4]),
      //   FlSpot(5, widget.monthSteps[5]),
      //   FlSpot(6, widget.monthSteps[6]),
      //   FlSpot(7, widget.monthSteps[7]),
      //   FlSpot(8, widget.monthSteps[8]),
      //   FlSpot(9, widget.monthSteps[9]),
      //   FlSpot(10, widget.monthSteps[10]),
      //   FlSpot(11, widget.monthSteps[11]),

      // ],
      spots: [
        FlSpot(0,0.0),
        FlSpot(1,0.0),
        FlSpot(2,0.0),
        FlSpot(3,0.0),
        FlSpot(4,0.0),
        FlSpot(5,0.0),
        FlSpot(6,0.0),
        FlSpot(7,0.0),
        FlSpot(8,0.0),
        FlSpot(9,0.0),
        FlSpot(10, 0.0),
        FlSpot(11, 0.0),

      ],
      isCurved: false,
      colors: const [
        Colors.orangeAccent,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: true,
        dotColor: Colors.orangeAccent
      ),
      belowBarData: const BarAreaData(
        show: false,
      ),
    );
    return [
      // lineChartBarData1,
      // lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    final now = DateTime.now();
    return LineChartData(
      lineTouchData: const LineTouchData(
        enabled: true,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          textStyle: TextStyle(
            // color: const Color(0xff72719b),
            fontFamily: 'Montserrat',
            fontSize: 12,
          ),

          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return DateFormat('EE').format(DateTime(now.year, now.month, now.day - 6));
              case 1:
                return DateFormat('EE').format(DateTime(now.year, now.month, now.day - 5));
              case 2:
                return DateFormat('EE').format(DateTime(now.year, now.month, now.day - 4));
              case 3:
                return DateFormat('EE').format(DateTime(now.year, now.month, now.day - 3));
              case 4:
                return DateFormat('EE').format(DateTime(now.year, now.month, now.day - 2));
              case 5:
                return DateFormat('EE').format(DateTime(now.year, now.month, now.day - 1));
              case 6:
                return DateFormat('EE').format(DateTime.now());
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            // color: const Color(0xff75729e),
            fontFamily: 'Montserrat',
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1000:
                return '1000';
              case 2000:
                return '2000';
              case 3000:
                return '3000';
              case 4000:
                return '4000';
              case 5000:
                return '5000';
            }
            return '';
          },

          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 2,
            ),
            left: BorderSide(
              color: Colors.white,
              width: 2
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 6,
      maxY: 5000,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      // const LineChartBarData(
      //   spots: [
      //     FlSpot(0, 2),
      //     FlSpot(1, 1),
      //     FlSpot(2, 4),
      //     FlSpot(3, 1.8),
      //     FlSpot(4, 5),
      //     FlSpot(5, 2),
      //     FlSpot(6, 2.2),
      //   ],
      //   isCurved: true,
      //   curveSmoothness: 0,
      //   colors: [
      //     Color(0x444af699),
      //   ],
      //   barWidth: 4,
      //   isStrokeCapRound: true,
      //   dotData: FlDotData(
      //     show: false,
      //   ),
      //   belowBarData: BarAreaData(
      //     show: false,
      //   ),
      // ),
      // const LineChartBarData(
      //   spots: [
      //     FlSpot(0, 1),
      //     FlSpot(1, 1),
      //     FlSpot(2, 2.8),
      //     FlSpot(3, 1.2),
      //     FlSpot(4, 2.8),
      //     FlSpot(5, 2.6),
      //     FlSpot(6, 3.9),
      //   ],
      //   isCurved: true,
      //   colors: [
      //     Color(0x99aa4cfc),
      //   ],
      //   barWidth: 4,
      //   isStrokeCapRound: true,
      //   dotData: FlDotData(
      //     show: false,
      //   ),
      //   belowBarData: BarAreaData(show: true, colors: [
      //     Color(0x33aa4cfc),
      //   ]),
      // ),
      LineChartBarData(
        spots: [
          FlSpot(0, widget.weekSteps[0]),
          FlSpot(1, widget.weekSteps[1]),
          FlSpot(2, widget.weekSteps[2]),
          FlSpot(3, widget.weekSteps[3]),
          FlSpot(4, widget.weekSteps[4]),
          FlSpot(5, widget.weekSteps[5]),
          FlSpot(6, widget.weekSteps[6]),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: [
          Colors.orangeAccent,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          dotColor: Colors.orangeAccent
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}